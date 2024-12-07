<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Order Placed</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orderPlaced.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h3>Order Placed Successfully!</h3>
		<p>Thank you for your purchase, ${user.name}.</p>
		<p>Your order details are as follows:</p>
		
		<p><strong>Order ID:</strong> ${order.orderId}</p>
		<p><strong>Order Date:</strong> ${order.orderDate}</p>
		<p><strong>Total Amount:</strong> $${order.totalAmount}</p>

		<h3>Order Items:</h3>
		<c:forEach var="orderItem" items="${orderItems}">
			<div class="order-item-card">
				<img src="${pageContext.request.contextPath}/${orderItem.car.imagePath}" alt="${orderItem.car.name}" class="order-item-image" />
				<strong>${orderItem.car.name}</strong><br/>
				Brand: ${orderItem.car.brand}<br/>
				Category: ${orderItem.car.category}<br/>
				Price: $${orderItem.price}<br/>
				Quantity: ${orderItem.quantity}<br/>
			</div>
		</c:forEach>
		
		<p><strong>A Confirmation Email has send to: </strong> ${user.email} [Wasn't implemented]</p>

		<div class="back-home">
			<a href="${pageContext.request.contextPath}/carMenu">Back to Home</a>
		</div>
	</div>
</body>
</html>
