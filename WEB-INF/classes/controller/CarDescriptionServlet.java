package controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.CarDAO;
import dao.CarDAOImpl;
import model.Car;

@WebServlet("/carDescription")
public class CarDescriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CarDAO carDAO;
	private Random random;

	public void init() {
		String dbURL = getServletContext().getRealPath("/dbFile/CarSales.db");
		System.out.println("Database URL: " + dbURL);
		carDAO = new CarDAOImpl(dbURL);
		random = new Random();
	}
	
	public CarDescriptionServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//get carId from request
		String carIdStr = request.getParameter("carId");
		if (carIdStr == null || carIdStr.isEmpty()) {
			response.sendRedirect("carMenu");
			return;
		}

		int carId;
		try {
			carId = Integer.parseInt(carIdStr);
		} catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("carMenu");
			return;
		}

		// retrieve car details
		Car car = carDAO.getCarById(carId);
		if (car == null) {
			response.sendRedirect("carMenu");
			return;
		}

		//generate dynamic information
		/*1. Kilometer: random between 100km - 300000km*/
		/*This implementation was just a simulation, in real world it suppose 
		 * be manual entered, here is just a way to proof a way to print the message*/
		int kilometers = 100 + random.nextInt(300000 - 100 + 1);

		// 2.transmission
		/*for transmission set default as 'automatic', if the car category is Sport, CONVERTIBLE, HATCHBACK, 
		 * then set the it as 'manual', also if the car price is lower than $10000, 
		 * set the transmission as manual also.*/
		String transmission = "Automatic";
		String category = car.getCategory();
		double price = car.getPrice();
		if (category.equalsIgnoreCase("Sport") || category.equalsIgnoreCase("CONVERTIBLE") || 
			category.equalsIgnoreCase("HATCHBACK") || price < 10000) {
			transmission = "Manual";
		}

		// 3. Drive Wheels
		/*for drivewheels part. we have 2 big part. 1 part if the car categoty is SEDAN, COUPE, HATCHBACK, CONVERTIBLE, Sport. 
		 * and if the price is lower than $40000, set them as "Front Wheel Drive (FWD) if them price is higher than $40000, 
		 * Set then as "Rear Wheel Drive (RWD). another part is the category is SUV, TRUCK 
		 * then set the drivewheels as "All Wheel Drive (AWD)".*/
		String driveWheels = "";
		if (category.equalsIgnoreCase("SEDAN") || category.equalsIgnoreCase("COUPE") ||
				category.equalsIgnoreCase("HATCHBACK") || category.equalsIgnoreCase("CONVERTIBLE") ||
				category.equalsIgnoreCase("Sport")) {
			if (price < 40000) {
				driveWheels = "Front Wheel Drive (FWD)";
			} else {
				driveWheels = "Rear Wheel Drive (RWD)";
			}
		} else if (category.equalsIgnoreCase("SUV") || category.equalsIgnoreCase("TRUCK")) {
			driveWheels = "All Wheel Drive (AWD)";
		} else {
			driveWheels = "Unknown Drive Wheels";
		}

		// 4. Fuel Consumption
		/*Same as before, here is wide guess, in real world had to use percise data to support
		 * All the value used at here is just assume, if this caused any problem please email me at
		 * Cxinhe5187@outlook.com, I will delete those*/
		double cityFuelConsumption = 0.0;
		double hwyFuelConsumption = 0.0;

		if (category.equalsIgnoreCase("SEDAN") || category.equalsIgnoreCase("COUPE")) {
			if (price < 40000) {
				cityFuelConsumption = 6.7;
				hwyFuelConsumption = 5.4;
			} else {
				cityFuelConsumption = 10.6;
				hwyFuelConsumption = 8.6;
			}
		} else if (category.equalsIgnoreCase("SUV") || category.equalsIgnoreCase("TRUCK")) {
			if (price < 40000) {
				cityFuelConsumption = 8.8;
				hwyFuelConsumption = 7.6;
			} else {
				cityFuelConsumption = 10.8;
				hwyFuelConsumption = 9.6;
			}
		} else if (category.equalsIgnoreCase("HATCHBACK") || category.equalsIgnoreCase("CONVERTIBLE")) {
			if (price < 40000) {
				cityFuelConsumption = 7.5;
				hwyFuelConsumption = 6.0;
			} else {
				cityFuelConsumption = 11.0;
				hwyFuelConsumption = 9.0;
			}
		} else if (category.equalsIgnoreCase("Sport")) {
			if (price < 40000) {
				cityFuelConsumption = 9.0;
				hwyFuelConsumption = 8.0;
			} else {
				cityFuelConsumption = 12.0;
				hwyFuelConsumption = 10.0;
			}
		} else {
			cityFuelConsumption = 0.0;
			hwyFuelConsumption = 0.0;
		}

		//set attributes for JSP
		request.setAttribute("car", car);
		request.setAttribute("kilometers", kilometers);
		request.setAttribute("transmission", transmission);
		request.setAttribute("driveWheels", driveWheels);
		request.setAttribute("cityFuelConsumption", cityFuelConsumption);
		request.setAttribute("hwyFuelConsumption", hwyFuelConsumption);

		// Forward to carDescription.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/carDescription.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
