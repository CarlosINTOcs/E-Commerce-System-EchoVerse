package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.UserDAO;
import dao.UserDAOImpl;
import model.User;

@WebServlet("/accountSetting")
public class AccountSettingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserDAO userDAO;

	public void init() {
	String dbURL = getServletContext().getRealPath("/dbFile/CarSales.db");
		userDAO = new UserDAOImpl(dbURL);
	}

	public AccountSettingServlet() {
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

		//set user attribute for JSP
		request.setAttribute("user", user);

		//forward to accountSetting.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/accountSetting.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User sessionUser = (session != null) ? (User) session.getAttribute("user") : null;

		if (sessionUser == null) {
			response.sendRedirect("jsp/login.jsp");
			return;
		}

		//get updated user information from the form
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		String bankAccount = request.getParameter("bankAccount");
		String expiryDate = request.getParameter("expiryDate");
		String email = request.getParameter("email");

		//validate inputs
		String errorMessage = null;
		if (password == null || password.isEmpty()) {
			errorMessage = "Password cannot be empty.";
		} else if (name == null || name.isEmpty()) {
			errorMessage = "Name cannot be empty.";
		} else if (address == null || address.isEmpty()) {
			errorMessage = "Address cannot be empty.";
		} else if (bankAccount != null && !bankAccount.isEmpty() && bankAccount.length() != 16) {
			errorMessage = "Bank account must be 16 digits.";
		} else if (expiryDate != null && !expiryDate.isEmpty() && expiryDate.length() != 4) {
			errorMessage = "Expiry date must be 4 digits (MMYY).";
		}

		if (errorMessage != null) {
			request.setAttribute("errorMessage", errorMessage);
			request.setAttribute("user", sessionUser);
			RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/accountSetting.jsp");
			dispatcher.forward(request, response);
			return;
		}

		//update user object
		sessionUser.setPassword(password);
		sessionUser.setName(name);
		sessionUser.setAddress(address);
		sessionUser.setBankAccount(bankAccount);
		sessionUser.setExpiryDate(expiryDate);
		sessionUser.setEmail(email);

		//update user in the database using updateUser2
		boolean success = userDAO.updateUser2(sessionUser);

		if (success) {
			//update the user in the session
			session.setAttribute("user", sessionUser);
			request.setAttribute("successMessage", "Account updated successfully.");
		} else {
			request.setAttribute("errorMessage", "Failed to update account. Please try again.");
		}

		//set user attribute for JSP
		request.setAttribute("user", sessionUser);

		//forward back to accountSetting.jsp
		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/accountSetting.jsp");
		dispatcher.forward(request, response);
	}
}
