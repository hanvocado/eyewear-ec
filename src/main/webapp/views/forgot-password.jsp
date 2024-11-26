<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
<h2>Forgot Password</h2>
<form action="${pageContext.request.contextPath}/forgot-password" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    <button type="submit">Send</button>
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