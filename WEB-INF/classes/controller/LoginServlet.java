package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.UserDAO;
import dao.UserDAOImpl;
import model.User;
import model.CartItem;
import dao.CartDAO;
import dao.CartDAOImpl;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserDAO userDAO;
	private CartDAO cartDAO;
	
	public void init() {
		String dbURL = getServletContext().getRealPath("/dbFile/CarSales.db");
		System.out.println("Database URL: " + dbURL);
		userDAO = new UserDAOImpl(dbURL);
		cartDAO = new CartDAOImpl(dbURL);
	}
       
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		User user = userDAO.loginUser(username, password);
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			//creates the session cart and pulls cartitems from table
			List<CartItem> cart = new ArrayList<>();
			List<CartItem> cartItems = cartDAO.getCartItemsByUserId(user.getUserId());
			double totalPrice = 0;
			for(CartItem cI: cartItems) {
				cart.add(cI);
				totalPrice = totalPrice + (cI.getCar().getPrice() * cI.getQuantity());
			}
  
			session.setAttribute("cart", cart);
			session.setAttribute("totalPrice", totalPrice);

			if (user.isAdmin()) {
				response.sendRedirect("admin");
			} else {
				response.sendRedirect("carMenu");
			}
		} else {
			request.setAttribute("errorMessage", "Invalid username or password");
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/login.jsp");
			dispatcher.forward(request, response);
		}
	}
}
