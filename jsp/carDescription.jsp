<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Car Description</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/carDescription.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
		<h2>Car Description</h2>
		<div class="car-details">
			<img src="${pageContext.request.contextPath}/${car.imagePath}" alt="${car.name}" class="car-image" />
            
			<div class="car-info">
				<p><strong>Name:</strong> ${car.name}</p>
				<p><strong>Brand:</strong> ${car.brand}</p>
				<p><strong>Category:</strong> ${car.category}</p>
				<p><strong>Price:</strong> $${car.price}</p>
				<p><strong>Inventory Left:</strong> ${car.inventory}</p>
				<p><strong>Kilometers:</strong> ${kilometers} km</p>
				<p><strong>Transmission:</strong> ${transmission}</p>
				<p><strong>Drive Wheels:</strong> ${driveWheels}</p>
			</div>
		</div>
        
		<!-- Additional Information Pictures and Data -->
		<div class="additional-info">
			<div class="info-section">
				<img src="${pageContext.request.contextPath}/images/kilometer.jpg" alt="Kilometers" class="info-image" />
				<p>Kilometers: ${kilometers} km</p>
			</div>
			<div class="info-section">
				<img src="${pageContext.request.contextPath}/images/transmission.jpg" alt="Transmission" class="info-image" />
				<p>Transmission: ${transmission}</p>
			</div>
			<div class="info-section">
				<img src="${pageContext.request.contextPath}/images/drivewheels.jpg" alt="Drive Wheels" class="info-image" />
				<p>Drive Wheels: ${driveWheels}</p>
			</div>
		</div>
        
        <!-- Fuel Consumption Information [detailed explain was in carDescriptionServlet.java file]-->
		<div class="fuel-consumption">
			<h3>Fuel Consumption</h3>
			<p><strong>City:</strong> ${cityFuelConsumption}/100km</p>
			<p><strong>Highway:</strong> ${hwyFuelConsumption}/100km</p>
		</div>
        
        <div class="back-button">
			<a href="${pageContext.request.contextPath}/carMenu" class="btn-submit">Back to Car Menu</a>
		</div>
	</div>
</body>
</html>
