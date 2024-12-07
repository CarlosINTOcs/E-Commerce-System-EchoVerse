package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dao.CarDAO;
import dao.CarDAOImpl;
import dao.OrderDAO;
import dao.OrderDAOImpl;
import dao.UserDAO;
import dao.UserDAOImpl;
import model.Car;
import model.Order;
import model.User;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CarDAO carDAO;
	private OrderDAO orderDAO;
	private UserDAO userDAO;

	public void init() {
		String dbURL = getServletContext().getRealPath("/dbFile/CarSales.db");
		carDAO = new CarDAOImpl(dbURL);
		orderDAO = new OrderDAOImpl(dbURL);
		userDAO = new UserDAOImpl(dbURL);
	}

	public AdminServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//check admin session
		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;
		if (user == null || !user.isAdmin()) {
			response.sendRedirect("jsp/login.jsp");
			return;
		}

		//fetch car list
		List<Car> carList = carDAO.getAllCars();
		request.setAttribute("carList", carList);

		//fetch order list
		List<Order> orderList = orderDAO.getAllOrders();
		request.setAttribute("orderList", orderList);

		//fetch user list
		List<User> userList = userDAO.getAllUsers();
		request.setAttribute("userList", userList);

		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/adminPage.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//check admin session
		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;
		if (user == null || !user.isAdmin()) {
			response.sendRedirect("jsp/login.jsp");
			return;
		}

		String action = request.getParameter("action");
		switch (action) {
		case "updateCar":
			updateCar(request, response);
			break;
		case "deleteCar":
			deleteCar(request, response);
			break;
		case "addCar":
			addCar(request, response);
			break;
		case "deleteUser":
			deleteUser(request, response);
			break;
		default:
			break;
		}
        //refresh the page
		response.sendRedirect(request.getContextPath() + "/admin");
	}

	private void updateCar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int carId = Integer.parseInt(request.getParameter("carId"));
		double price = Double.parseDouble(request.getParameter("price"));
		int inventory = Integer.parseInt(request.getParameter("inventory"));

		Car car = carDAO.getCarById(carId);
		if (car != null) {
			car.setPrice(price);
			car.setInventory(inventory);
			carDAO.updateCar(car);
		}
	}

	private void deleteCar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int carId = Integer.parseInt(request.getParameter("carId"));
		carDAO.deleteCar(carId);
	}

	private void addCar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String brand = request.getParameter("brand");
		String category = request.getParameter("category");
		double price = Double.parseDouble(request.getParameter("price"));
		int inventory = Integer.parseInt(request.getParameter("inventory"));
		String imagePath = request.getParameter("imagePath");

		Car newCar = new Car();
		newCar.setName(name);
		newCar.setBrand(brand);
		newCar.setCategory(category);
		newCar.setPrice(price);
		newCar.setInventory(inventory);
		newCar.setImagePath(imagePath);

		carDAO.addCar(newCar);
	}

	private void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		//prevent admin from deleting themselves
		HttpSession session = request.getSession(false);
		User currentUser = (User) session.getAttribute("user");
		if (currentUser.getUserId() == userId) {
			//optionally, set an error message or handle accordingly
			return;
		}
		userDAO.deleteUser(userId);
	}
}
