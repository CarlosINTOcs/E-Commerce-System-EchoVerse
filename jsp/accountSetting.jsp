<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>Account Setting</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
	<h2>Account Settings for ${user.username}</h2>
    
	<div class="form-group">
	<nav class="navbar">
	<a href="${pageContext.request.contextPath}/carMenu">All Vehicles</a> |
	<a href="${pageContext.request.contextPath}/cart">View Cart</a> |
	<a href="${pageContext.request.contextPath}/logout">Logout</a>
	</nav>
	</div>
	
	<c:if test="${not empty errorMessage}">
		<p style="color:red">${errorMessage}</p>
	</c:if>
	<c:if test="${not empty successMessage}">
		<p style="color:green">${successMessage}</p>
	</c:if>
    
	<!-- Account Information Form -->
	<div class="form-group">
	<form action="${pageContext.request.contextPath}/accountSetting" method="post" class="login-form">
		<table>
			<tr>
				<td>User ID:</td>
				<td><input type="text" name="userId" value="${user.userId}" readonly /></td>
			</tr>
			<tr>
				<td>Username:</td>
				<td><input type="text" name="username" value="${user.username}" readonly /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type="password" name="password" value="${user.password}" /></td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name" value="${user.name}" /></td>
			</tr>
			<tr>
				<td>Address:</td>
				<td><input type="text" name="address" value="${user.address}" /></td>
			</tr>
			<tr>
				<td>Bank Account:</td>
				<td><input type="text" name="bankAccount" value="${user.bankAccount}" /></td>
			</tr>
			<tr>
				<td>Expiry Date (MMYY):</td>
				<td><input type="text" name="expiryDate" value="${user.expiryDate}" /></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="email" value="${user.email}" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="Update" />
					<a href="${pageContext.request.contextPath}/carMenu">Back to Car Menu</a>
				</td>
			</tr>
		</table>
	</form>
	</div>
	</div>
</body>
</html>
