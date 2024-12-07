<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Cart</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cart.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h2>Welcome, ${user.name}</h2>

		<!-- Navigation Bar -->
		<nav class="navbar">
			<a href="${pageContext.request.contextPath}/carMenu">All Vehicles</a> |
			<a href="${pageContext.request.contextPath}/cart">View Cart</a> |
			<a href="${pageContext.request.contextPath}/logout">Logout</a>
		</nav>
        
		<h3>Your Cart</h3>
        
		<c:if test="${not empty message}">
			<p class="error-message">${message}</p>
		</c:if>
        
		<form action="${pageContext.request.contextPath}/UpdateCartServlet" method="post" class="cart-form">
			<div class="cart-items">
				<c:forEach var="cartItem" items="${cart}">
					<div class="cart-item-card">
						<img src="${pageContext.request.contextPath}/${cartItem.car.imagePath}" alt="${cartItem.car.name}" class="cart-item-image" />
						<div class="cart-item-info">
							<h4>${cartItem.car.name}</h4>
							<p><strong>Brand:</strong> ${cartItem.car.brand}</p>
							<p><strong>Category:</strong> ${cartItem.car.category}</p>
							<p><strong>Price:</strong> $${cartItem.car.price}</p>
							<p><strong>Quantity:</strong> 
								<input type="number" name="quantity_${cartItem.carId}" value="${cartItem.quantity}" min="1" max="${cartItem.car.inventory}" required />
							</p>
							<p>
								<input type="checkbox" name="delete_${cartItem.carId}" id="delete_${cartItem.carId}" />
								<label for="delete_${cartItem.carId}">Remove this item</label>
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div class="cart-actions">
				<p><strong>Total Price:</strong> $${totalPrice}</p>
				<input type="submit" value="Update Cart" class="btn-submit" />
				<a href="${pageContext.request.contextPath}/CheckoutServlet" class="btn-checkout">Checkout</a>
			</div>
		</form>
        
		<p class="continue-shopping"><a href="${pageContext.request.contextPath}/carMenu">Select More Vehicles</a></p>
	</div>
</body>
</html>
