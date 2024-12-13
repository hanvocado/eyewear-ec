<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Account List</title>
</head>
<body>
<h1>Account List</h1>
<table>
    <thead>
    <tr>
        <th>Email</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Phone</th>
        <th>Picture</th>
        <th>Branch Name</th>
        <th>Branch Address</th>
        <th>Customer Address</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.email}</td>
            <td>${user.firstName}</td>
            <td>${user.lastName}</td>
            <td>${user.phone}</td>
            <td><img src="${user.picture}" alt="Picture" width="50" height="50"/></td>
            <c:choose>
                <c:when test="${user.role == 'MANAGER'}">
                    <td>${user.branch.name}</td>
                    <td>${user.branch.address.streetNumber} ${user.branch.address.streetName}, ${user.branch.address.commue}, ${user.branch.address.district}, ${user.branch.address.province}</td>
                    <td>N/A</td>
                </c:when>
                <c:when test="${user.role == 'BUYER'}">
                    <td>N/A</td>
                    <td>N/A</td>
                    <td>${user.address.streetNumber} ${user.address.streetName}, ${user.address.commue}, ${user.address.district}, ${user.address.province}</td>
                </c:when>
            </c:choose>
            <td>
                <a href="/admin/accounts/edit/${user.id}">Edit</a>
                <a href="/admin/accounts/delete/${user.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>