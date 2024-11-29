<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
<h2>Reset Password</h2>
<form action="${pageContext.request.contextPath}/reset-password" method="post">
    <input type="hidden" name="token" value="${token}">
    <label for="password">New Password:</label>
    <input type="password" id="password" name="password" required>
    <label for="confirmPassword">Confirm Password:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required>
    <button type="submit">Reset Password</button>
</form>

<!-- Handle success message -->
<c:if test="${not empty message}">
    <p>${message}</p>
</c:if>

<!-- Handle error message -->
<c:if test="${not empty error}">
    <p>${error}</p>
</c:if>
</body>
</html>