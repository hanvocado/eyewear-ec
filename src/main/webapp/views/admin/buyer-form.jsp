<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${buyer.id == null ? 'Thêm mới' : 'Cập nhật'} Khách hàng</title>
</head>
<body class="page-header-fixed page-quick-sidebar-over-content">
<div class="page-container">
    <div class="page-content">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="portlet">
                        <div class="portlet-title">
                            <div class="caption">
                                ${buyer.id == null ? 'Thêm mới' : 'Cập nhật'} tài khoản Khách hàng
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <form:form modelAttribute="buyer" method="POST" cssClass="form-horizontal">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Email</label>
                                        <div class="col-md-6">
                                            <form:input path="email" class="form-control" required="true"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Mật khẩu</label>
                                        <div class="col-md-6">
                                            <form:password path="password" class="form-control" required="true"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Xác nhận mật khẩu</label>
                                        <div class="col-md-6">
                                            <form:password path="confirmPassword" class="form-control" required="true"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Họ</label>
                                        <div class="col-md-6">
                                            <form:input path="firstName" class="form-control" required="true"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Tên</label>
                                        <div class="col-md-6">
                                            <form:input path="lastName" class="form-control" required="true"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Số điện thoại</label>
                                        <div class="col-md-6">
                                            <form:input path="phone" class="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Số nhà</label>
                                        <div class="col-md-6">
                                            <form:input path="streetNumber" class="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Tên đường</label>
                                        <div class="col-md-6">
                                            <form:input path="streetName" class="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Phường/Xã</label>
                                        <div class="col-md-6">
                                            <form:input path="commue" class="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Quận/Huyện</label>
                                        <div class="col-md-6">
                                            <form:input path="district" class="form-control"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Tỉnh/Thành phố</label>
                                        <div class="col-md-6">
                                            <form:input path="province" class="form-control"/>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            <button type="submit" class="btn btn-circle blue">Lưu</button>
                                            <a href="/admin/accounts/buyers" class="btn btn-circle default">Hủy</a>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>