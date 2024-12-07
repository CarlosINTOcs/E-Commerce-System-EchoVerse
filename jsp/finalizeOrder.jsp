<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Finalize Order</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/finalizeOrder.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h3>Finalize Your Order:</h3>
		<p><strong>Name:</strong> ${user.name}</p>
		<p><strong>Card Number:</strong> ${user.bankAccount}</p>
		<p><strong>Expiration Date:</strong> ${user.expiryDate}</p>
		<p><strong>Address:</strong> ${user.address}</p>
		<p><strong>Email:</strong> ${user.email}</p>

		<c:forEach var="cartItem" items="${cart}">
			<div class="cart-item-card">
				<img src="${pageContext.request.contextPath}/${cartItem.car.imagePath}" alt="${cartItem.car.name}" class="cart-item-image" />
				<div class="cart-item-info">
					<h4>${cartItem.car.name}</h4>
					<p><strong>Brand:</strong> ${cartItem.car.brand}</p>
					<p><strong>Category:</strong> ${cartItem.car.category}</p>
					<p><strong>Price:</strong> $${cartItem.car.price}</p>
					<p><strong>Quantity:</strong> ${cartItem.quantity}</p>
				</div>
			</div>
		</c:forEach>
		<p class="total-price"><strong>Total Price:</strong> $${totalPrice}</p>

		<form action="${pageContext.request.contextPath}/PlaceOrderServlet" method="post" class="cart-form">
			<input type="submit" value="Checkout" class="btn-submit" />
		</form>

		<div class="continue-shopping">
			<a href="${pageContext.request.contextPath}/carMenu">Back to Home</a>
		</div>
	</div>
</body>
</html>
