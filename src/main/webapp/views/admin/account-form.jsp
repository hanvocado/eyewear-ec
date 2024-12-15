<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Account Form</title>
</head>
<body>
<h1>Account Form</h1>
<form:form method="post" modelAttribute="user" class="form-horizontal" action="/admin/accounts/save">
  <div class="form-group">
    <form:label path="email" class="col-sm-2 control-label">Email</form:label>
    <div class="col-sm-10">
      <form:input path="email" class="form-control" required="true"/>
    </div>
  </div>
  <div class="form-group">
    <form:label path="firstName" class="col-sm-2 control-label">First Name</form:label>
    <div class="col-sm-10">
      <form:input path="firstName" class="form-control" required="true"/>
    </div>
  </div>
  <div class="form-group">
    <form:label path="lastName" class="col-sm-2 control-label">Last Name</form:label>
    <div class="col-sm-10">
      <form:input path="lastName" class="form-control" required="true"/>
    </div>
  </div>
  <div class="form-group">
    <form:label path="phone" class="col-sm-2 control-label">Phone</form:label>
    <div class="col-sm-10">
      <form:input path="phone" class="form-control" required="true"/>
    </div>
  </div>
  <div class="form-group">
    <form:label path="picture" class="col-sm-2 control-label">Picture</form:label>
    <div class="col-sm-10">
      <form:input path="picture" class="form-control" required="true"/>
    </div>
  </div>
  <c:choose>
    <c:when test="${user.role == 'MANAGER'}">
      <div class="form-group">
        <form:label path="branch.name" class="col-sm-2 control-label">Branch Name</form:label>
        <div class="col-sm-10">
          <form:input path="branch.name" class="form-control" required="true"/>
        </div>
      </div>
      <div class="form-group">
        <form:label path="branch.address" class="col-sm-2 control-label">Branch Address</form:label>
        <div class="col-sm-10">
          <form:input path="branch.address" class="form-control" required="true"/>
        </div>
      </div>
    </c:when>
    <c:when test="${user.role == 'BUYER'}">
      <div class="form-group">
        <form:label path="address" class="col-sm-2 control-label">Customer Address</form:label>
        <div class="col-sm-10">
          <form:input path="address" class="form-control" required="true"/>
        </div>
      </div>
    </c:when>
  </c:choose>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-primary">Save</button>
    </div>
  </div>
</form:form>
</body>
</html>