<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý tài khoản Manager</title>
</head>
<body class="page-header-fixed page-quick-sidebar-over-content">
    <div class="page-container">
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet">
                            <div class="portlet-title">
                                <div class="caption">Danh sách tài khoản Manager</div>
                                <div class="actions">
                                    <a href="/admin/accounts/managers/add" class="btn btn-circle btn-primary">
                                        <i class="fa fa-plus"></i> Thêm mới
                                    </a>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <table class="table table-striped table-hover">
                                    <thead>
                                    <tr>
                                        <th>Email</th>
                                        <th>Họ tên</th>
                                        <th>Số điện thoại</th>
                                        <th>Chi nhánh</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="manager" items="${managers}">
                                        <tr>
                                            <td>${manager.email}</td>
                                            <td>${manager.firstName} ${manager.lastName}</td>
                                            <td>${manager.phone}</td>
                                            <td>${manager.branch.name}</td>
                                            <td>
                                                <a href="/admin/accounts/managers/edit/${manager.id}" class="btn btn-circle btn-warning btn-sm">
                                                    <i class="fa fa-edit"></i>
                                                </a>
                                                <a href="/admin/accounts/managers/delete/${manager.id}"
                                                   class="btn btn-circle btn-danger btn-sm"
                                                   onclick="return confirm('Bạn có chắc muốn xóa?')">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>