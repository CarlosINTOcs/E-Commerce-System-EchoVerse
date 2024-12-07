<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>Register</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">
<h2>Register</h2>
<form action="${pageContext.request.contextPath}/register" method="post" class="login-form">
	<div class="input-group">
		<label for="name">Name:</label>
		<input type="text" name="name" required /><br/>
	</div>
	<div class="input-group">
		<label for="username">Username:</label>
		<input type="text" name="username" required /><br/>
	</div>
	<div class="input-group">
		<label for="password">Password:</label>
		<input type="password" name="password" required /><br/>
	</div>
	<div class="input-group">
		<input type="submit" value="Register" class="btn-submit"/>
	</div>
</form>
<c:if test="${not empty errorMessage}">
	<p style="color:red">${errorMessage}</p>
</c:if>
</div>
</body>
</html>
