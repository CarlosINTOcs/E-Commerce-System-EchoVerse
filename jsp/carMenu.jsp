<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>Car Menu</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/carMenu.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/carMenu.js" defer></script>
</head>
<body>
	<div class="page-container">
		<!-- Sidebar for Search and Filter -->
		<aside class="sidebar">
			<!-- Search Box -->
			<form action="${pageContext.request.contextPath}/search" method="post" class="search-form">
				<div class="form-group">
					<label for="search">Search:</label>
					<input type="text" class="input" name="search" id="search" placeholder="Search for cars..." />
				</div>
				<div class="form-group">
					<input type="submit" name="searchCars" value="Search" class="btn-submit" />
				</div>
			</form>

			<!-- Filter and Sort Search -->
			<form action="${pageContext.request.contextPath}/carMenu" method="get" class="filter-form">
				<!-- Existing filter fields -->
				<div class="form-group">
					<label for="brand">Brand:</label>
					<select name="brand" id="brand" class="select-input">
						<option value="">[Please select]</option>
						<option value="Acura">Acura</option>
						<option value="Audi">Audi</option>
						<option value="BMW">BMW</option>
						<option value="Buick">Buick</option>
						<option value="Cadillac">Cadillac</option>
						<option value="Chevrolet">Chevrolet</option>
						<option value="Dodge">Dodge</option>
						<option value="Ford">Ford</option>
						<option value="Honda">Honda</option>
						<option value="Hyundai">Hyundai</option>
						<option value="Infiniti">Infiniti</option>
						<option value="Jaguar">Jaguar</option>
						<option value="Jeep">Jeep</option>
						<option value="Kia">Kia</option>
						<option value="Land Rover">Land Rover</option>
						<option value="Lexus">Lexus</option>
						<option value="Mazda">Mazda</option>
						<option value="Mercedes">Mercedes</option>
						<option value="Mitsubshi">Mitsubshi</option>
						<option value="Nissan">Nissan</option>
						<option value="Porsche">Porsche</option>
						<option value="RAM">RAM</option>
						<option value="Subaru">Subaru</option>
						<option value="Tesla">Tesla</option>
						<option value="Toyota">Toyota</option>
						<option value="Volkswagen">Volkswagen</option>
						<option value="Volvo">Volvo</option>
					</select>
				</div>

				<div class="form-group">
					<label for="category">Category:</label>
					<select name="category" id="category" class="select-input">
						<option value="">[Please select]</option>
						<option value="SEDAN">SEDAN</option>
						<option value="COUPE">COUPE</option>
						<option value="SUV">SUV</option>
						<option value="TRUCK">TRUCK</option>
						<option value="HATCHBACK">HATCHBACK</option>
						<option value="CONVERTIBLE">CONVERTIBLE</option>
						<option value="Sport">Sport</option>
					</select>
				</div>

				<div class="form-group">
					<label for="minPrice">Minimum Price:</label>
					<select name="minPrice" id="minPrice" class="select-input">
						<option value="">[Please select]</option>
						<option value="1000">$1,000.00</option>
						<option value="10000">$10,000.00</option>
						<option value="25000">$25,000.00</option>
						<option value="50000">$50,000.00</option>
						<option value="75000">$75,000.00</option>
						<option value="100000">$100,000.00</option>
						<option value="250000">$250,000.00</option>
						<option value="500000">$500,000.00</option>
						<option value="1000000">$1,000,000.00</option>
					</select>
				</div>

				<div class="form-group">
					<label for="maxPrice">Max Price:</label>
					<select name="maxPrice" id="maxPrice" class="select-input">
						<option value="">[Please select]</option>
						<option value="1000">$1,000.00</option>
						<option value="10000">$10,000.00</option>
						<option value="25000">$25,000.00</option>
						<option value="50000">$50,000.00</option>
						<option value="75000">$75,000.00</option>
						<option value="100000">$100,000.00</option>
						<option value="250000">$250,000.00</option>
						<option value="500000">$500,000.00</option>
						<option value="1000000">$1,000,000.00</option>
					</select>
				</div>

				<!-- Sort By -->
				<div class="form-group">
					<label for="sortBy">Sort By:</label>
					<select name="sortBy" id="sortBy" class="select-input">
						<option value="">[Please select]</option>
						<option value="price">Price</option>
						<option value="name">Name</option>
					</select>
				</div>
                
				<!-- Sort Order -->
				<div class="form-group">
					<label for="sortOrder">Order:</label>
					<select name="sortOrder" id="sortOrder" class="select-input">
						<option value="">[Please select]</option>
						<option value="asc">Ascending</option>
						<option value="desc">Descending</option>
					</select>
				</div>

				<div class="form-group">
					<input type="submit" name="searchCars" value="Filter" class="btn-submit" />
				</div>
			</form>
		</aside>
        
		<!-- Main Content -->
		<main class="main-content">
			<h2>Welcome, ${user.name}, see anything you like?</h2>

			<!-- Navigation -->
			<nav class="navbar">
				<a href="${pageContext.request.contextPath}/carMenu">All Vehicles</a> |
				<a href="${pageContext.request.contextPath}/jsp/cart.jsp">View Cart</a> |
				<a href="${pageContext.request.contextPath}/accountSetting">Account Setting</a> |
				<a href="${pageContext.request.contextPath}/logout">Logout</a>
			</nav>
            
			<!-- Activity Bar (Carousel) -->
			<div class="carousel-container">
				<button class="carousel-btn left-btn">&#10094;</button>
				<div class="carousel-slide">
					<img src="${pageContext.request.contextPath}/images/bar1.jpg" alt="Bar Image 1" class="carousel-image active">
					<img src="${pageContext.request.contextPath}/images/bar2.jpg" alt="Bar Image 2" class="carousel-image">
					<img src="${pageContext.request.contextPath}/images/bar3.jpg" alt="Bar Image 3" class="carousel-image">
				</div>
				<button class="carousel-btn right-btn">&#10095;</button>
			</div>
            
			<!-- Vehicles -->
			<h3>Our Vehicles:</h3>
			<c:if test="${not empty confirmationMessage}">
				<p class="error-message">${confirmationMessage}</p>
			</c:if>
            
			<div class="vehicle-list">
				<c:forEach var="car" items="${carList}">
					<div class="vehicle-card">
						<img src="${pageContext.request.contextPath}/${car.imagePath}" alt="${car.name}" class="vehicle-image" />
						<div class="vehicle-info">
							<h4>${car.name}</h4>
							<p><strong>Brand:</strong> ${car.brand}</p>
							<p><strong>Category:</strong> ${car.category}</p>
							<p><strong>Price:</strong> $${car.price}</p>
							<p><strong>Inventory Left:</strong> ${car.inventory}</p>

							<!-- Add to Cart Form -->
							<form action="${pageContext.request.contextPath}/addToCart" method="post" class="add-to-cart-form">
								<input type="hidden" name="carId" value="${car.carId}" />
								<label for="quantity_${car.carId}">Quantity:</label>
								<input type="number" name="quantity" id="quantity_${car.carId}" value="1" min="1" max="${car.inventory}" required />
								<input type="submit" value="Add to Cart" class="btn-submit" />
							</form>

							<!-- Info Icon -->
							<img src="${pageContext.request.contextPath}/images/trademark-logo.png" alt="Info" class="info-icon" data-category="${car.category}" />
                            
							<!-- Tooltip -->
							<div class="tooltip" id="tooltip_${car.carId}"></div>

							<!-- View Details Button -->
							<a href="${pageContext.request.contextPath}/carDescription?carId=${car.carId}" target="_blank" class="btn-view-details">View Details</a>
						</div>
					</div>
				</c:forEach>
			</div>       
		</main>
	</div>
</body>
</html>
