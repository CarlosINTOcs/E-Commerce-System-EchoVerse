<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>Admin Page</title>
	<style>
	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}

	th, td {
		padding: 8px 12px;
		border: 1px solid #ccc;
		text-align: center;
	}

	th {
		background-color: #f4f4f4;
	}

	form {
		margin: 0;
	}

	input[type="text"] {
		width: 90%;
		padding: 4px;
	}

	input[type="submit"] {
		padding: 4px 8px;
		margin-left: 4px;
	}
    </style>
</head>
<body>
<h2>Administrator Dashboard</h2>
<nav>
	<a href="${pageContext.request.contextPath}/logout">Logout</a>
</nav>

<h3>Car Inventory Management</h3>
<table>
	<tr>
		<th>Car ID</th>
		<th>Name</th>
		<th>Brand</th>
		<th>Category</th>
		<th>Price</th>
		<th>Inventory</th>
		<th>Actions</th>
	</tr>
	<c:forEach var="car" items="${carList}">
		<tr>
			<td>${car.carId}</td>
			<td>${car.name}</td>
			<td>${car.brand}</td>
			<td>${car.category}</td>
			<td>
				<form action="${pageContext.request.contextPath}/admin" method="post">
					<input type="text" name="price" value="${car.price}" size="6" />
			</td>
			<td>
					<input type="text" name="inventory" value="${car.inventory}" size="4" />
					<input type="hidden" name="action" value="updateCar" />
					<input type="hidden" name="carId" value="${car.carId}" />
					<input type="submit" value="Update" />
				</form>
			</td>
			<td>
				<!-- Delete Car Form -->
				<form action="${pageContext.request.contextPath}/admin" method="post">
					<input type="hidden" name="action" value="deleteCar" />
					<input type="hidden" name="carId" value="${car.carId}" />
					<input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this car?');" />
				</form>
			</td>
		</tr>
	</c:forEach>
</table>


<h3>Add New Car</h3>
<form action="${pageContext.request.contextPath}/admin" method="post">
	<input type="hidden" name="action" value="addCar" />
	<table>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="name" required /></td>
		</tr>
		<tr>
			<td>Brand:</td>
			<td><input type="text" name="brand" required /></td>
		</tr>
		<tr>
			<td>Category:</td>
			<td><input type="text" name="category" required /></td>
		</tr>
		<tr>
			<td>Price:</td>
			<td><input type="text" name="price" required /></td>
		</tr>
		<tr>
			<td>Inventory:</td>
			<td><input type="text" name="inventory" required /></td>
		</tr>
		<tr>
			<td>Image Path:</td>
			<td><input type="text" name="imagePath" /></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="Add Car" /></td>
		</tr>
	</table>
</form>

<h3>Order Details</h3>
<table>
    <tr>
        <th>Order ID</th>
        <th>User ID</th>
        <th>Order Date</th>
        <th>Total Amount</th>
    </tr>
    <c:forEach var="order" items="${orderList}">
        <tr>
            <td>${order.orderId}</td>
            <td>${order.userId}</td>
            <td>${order.orderDate}</td>
            <td>${order.totalAmount}</td>
        </tr>
    </c:forEach>
</table>

<h3>User Management</h3>
<table>
    <tr>
        <th>User ID</th>
        <th>Username</th>
        <th>Name</th>
        <th>Bank Account</th>
        <th>Expiry Date</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="user" items="${userList}">
        <tr>
            <td>${user.userId}</td>
            <td>${user.username}</td>
            <td>${user.name}</td>
            <td>${user.bankAccount}</td>
            <td>${user.expiryDate}</td>
            <td>
                <!-- Delete User Form -->
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <input type="hidden" name="action" value="deleteUser" />
                    <input type="hidden" name="userId" value="${user.userId}" />
                    <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');" />
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
