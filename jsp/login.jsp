<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h2>Hi! Welcome to Echo Verse Auto Shop</h2>
		<form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
			<div class="input-group">
				<label for="username">Username:</label>
				<input type="text" name="username" id="username" required />
			</div>
			<div class="input-group">
				<label for="password">Password:</label>
				<input type="password" name="password" id="password" required />
			</div>
			<div class="input-group">
				<input type="submit" value="Login" class="btn-submit" />
			</div>
		</form>
		<p>Don't have an account? <a href="${pageContext.request.contextPath}/jsp/register.jsp">Sign up here</a></p>
		<c:if test="${not empty errorMessage}">
			<p class="error-message">${errorMessage}</p>
		</c:if>
	</div>
</body>
</html>
