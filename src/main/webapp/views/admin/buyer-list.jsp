<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý tài khoản Khách hàng</title>
</head>
<body class="page-header-fixed page-quick-sidebar-over-content">
    <div class="page-container">
        <div class="page-content">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet">
                            <div class="portlet-title">
                                <div class="caption">Danh sách tài khoản Khách hàng</div>
                                <div class="actions">
                                    <a href="/admin/accounts/buyers/add" class="btn btn-circle btn-primary">
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
                                            <th>Địa chỉ</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="buyer" items="${buyers}">
                                            <tr>
                                                <td>${buyer.email}</td>
                                                <td>${buyer.firstName} ${buyer.lastName}</td>
                                                <td>${buyer.phone}</td>
                                                <td>
                                                    ${buyer.address.streetNumber} ${buyer.address.streetName},
                                                    ${buyer.address.commue}, ${buyer.address.district},
                                                    ${buyer.address.province}
                                                </td>
                                                <td>
                                                    <a href="/admin/accounts/buyers/edit/${buyer.id}" class="btn btn-circle btn-warning btn-sm">
                                                        <i class="fa fa-edit"></i>
                                                    </a>
                                                    <a href="/admin/accounts/buyers/delete/${buyer.id}" 
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