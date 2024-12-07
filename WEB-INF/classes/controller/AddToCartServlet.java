package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.CarDAO;
import dao.CarDAOImpl;
import dao.CartDAO;
import dao.CartDAOImpl;
import model.Car;
import model.User;
import model.CartItem;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CarDAO carDAO;
	private CartDAO cartDAO;

	public void init() {
		String dbURL = getServletContext().getRealPath("/dbFile/CarSales.db");
		System.out.println("Database URL: " + dbURL);
		carDAO = new CarDAOImpl(dbURL);
		cartDAO = new CartDAOImpl(dbURL);
	}

	public AddToCartServlet() {
		super();
	}

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;
		if (user == null) {
			response.sendRedirect("jsp/login.jsp");
			return;
		}

		int carId = Integer.parseInt(request.getParameter("carId"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		System.out.println("Adding to cart: carId = " + carId + " | quantity = " + quantity);

		//get the cart from session
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
		double totalPrice = (double) session.getAttribute("totalPrice");

		boolean itemExistsInCart = false;
		for (CartItem cItem : cart) {
			if (cItem.getCarId() == carId) {
				//item exists, update quantity
				cItem.setQuantity(cItem.getQuantity() + quantity);
				//update in database
				cartDAO.updateCartItem(cItem);
				itemExistsInCart = true;
				break;
			}
		}

		if (!itemExistsInCart) {
			//item not in cart, create new CartItem
			CartItem cartItem = new CartItem();
			cartItem.setCarId(carId);
			cartItem.setQuantity(quantity);
			cartItem.setCar(carDAO.getCarById(carId));
			cartItem.setUserId(user.getUserId());
			//add to database (this will set cartItemId)
			cartDAO.addCartItem(cartItem);
			//add to session cart
			cart.add(cartItem);
		}

		//recalculate total price
		totalPrice += carDAO.getCarById(carId).getPrice() * quantity;
		totalPrice = Math.round(totalPrice * 100000d) / 100000d;
		session.setAttribute("totalPrice", totalPrice);
		session.setAttribute("cart", cart);

		request.setAttribute("confirmationMessage", "--------------- Added " + quantity + " " + carDAO.getCarById(carId).getName() + " to Cart ---------------");

		RequestDispatcher dispatcher = request.getRequestDispatcher("carMenu");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
