package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CarDAO;
import dao.CarDAOImpl;
import model.Car;
import model.User;

@WebServlet("/carMenu")
public class CarMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CarDAO carDAO;

	public void init() {
		String dbURL = getServletContext().getRealPath("/dbFile/CarSales.db");
		System.out.println("Database URL: " + dbURL);
		carDAO = new CarDAOImpl(dbURL);
	}

	public CarMenuServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//check user session
		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("user") : null;
		if (user == null) {
			response.sendRedirect("jsp/login.jsp");
			return;
		}

		//get filter parameters
		String brand = request.getParameter("brand");
		String category = request.getParameter("category");
		String minPriceStr = request.getParameter("minPrice");
		String maxPriceStr = request.getParameter("maxPrice");
		String sortBy = request.getParameter("sortBy");
		String sortOrder = request.getParameter("sortOrder");

		Double minPrice = null;
		Double maxPrice = null;

		//parse price parameters
		try {
			if (minPriceStr != null && !minPriceStr.isEmpty()) {
				minPrice = Double.parseDouble(minPriceStr);
			}
			if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
				maxPrice = Double.parseDouble(maxPriceStr);
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
			//handle parsing errors, possibly set a confirmation message
			request.setAttribute("confirmationMessage", "Invalid price format.");
		}

		List<Car> carList;

		// check if any filter or sorter is applied
		if ((brand != null && !brand.isEmpty()) ||
				(category != null && !category.isEmpty()) ||
				minPrice != null || maxPrice != null ||
				(sortBy != null && !sortBy.isEmpty()) ||
				(sortOrder != null && !sortOrder.isEmpty())) {
			//at least one filter or sorter is selected
			carList = carDAO.searchCarsByCondition(brand, category, minPrice, maxPrice, sortBy, sortOrder);
		} else {
			// no filters or sorters selected, get all cars
			carList = carDAO.getAllCars();
		}

		request.setAttribute("carList", carList);
		request.setAttribute("user", user);
		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/carMenu.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
