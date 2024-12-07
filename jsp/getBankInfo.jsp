<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bank Info</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
	<h2>Welcome, ${user.name}</h2>
	<h3>Enter your Banking Info:</h3>
	
	<c:if test="${not empty errorMessage}">
		<p style="color:red">${errorMessage}</p>
	</c:if>
	<form action="${pageContext.request.contextPath}/UpdateUserServlet" method="post" class="login-form">
		<div class="input-group">
		<span class="fieldName">Name: </span>
		<input type= "text" class="input" name="name"><br>
		</div>
		
		<div class="input-group">
		<span class="fieldName">Card Number: </span>
		<input type= "text" class="input" name="bankcard"><br>
		</div>
		
		<div class="input-group">
		<span class="fieldName">Expiration Date: </span>
		<input type= "text" class="input" name="expiry"><br>
		</div>
		
		<div class="input-group">
		<span class="fieldName">CVV: </span>
		<input type= "text" class="input" name="cvv"><br>
		</div>
		
		<div class="input-group">
		<span class="fieldName">Address: </span>
		<input type= "text" class="input" name="address"><br>
		</div>
		
		<div class="input-group">
		<span class="fieldName">Email: </span>
		<input type="text" class="input" name="email"><br>
		</div>
		
		<div class="input-group">
		<br><input type="submit" value="Update Info" />
		</div>
	</form>
	</div>
	
</body>
</html>