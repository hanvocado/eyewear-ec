<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty manager.email ? 'Thêm mới' : 'Cập nhật'} Manager</title>
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
                                <i class="fa fa-user"></i> ${empty manager.email ? 'Thêm mới' : 'Cập nhật'} Manager
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <!-- Display success and error messages -->
                            <c:if test="${not empty success}">
                                <div class="alert alert-success">${success}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <!-- Form Content -->
                            <form action="${empty manager.email ? '/admin/accounts/managers/save' : ''}" method="POST" class="form-horizontal">
                                <div class="form-body">
                                    <!-- Email field -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Email <span class="required">*</span></label>
                                        <div class="col-md-6">
                                            <input type="text" name="email" class="form-control" value="${manager.email != null ? manager.email : ''}"/>
                                            <span class="help-block error-text">${errors.email}</span>
                                        </div>
                                    </div>

                                    <!-- Password field -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Mật khẩu<span class="required">*</span></label>
                                        <div class="col-md-6">
                                            <input type="password" name="password" class="form-control"/>
                                            <span class="help-block error-text">${errors.password}</span>
                                        </div>
                                    </div>

                                    <!-- Confirm Password field -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Xác nhận mật khẩu<span class="required">*</span></label>
                                        <div class="col-md-6">
                                            <input type="password" name="confirmPassword" class="form-control"/>
                                            <span class="help-block error-text">${errors.confirmPassword}</span>
                                        </div>
                                    </div>

                                    <!-- First Name field -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Họ</label>
                                        <div class="col-md-6">
                                            <input type="text" name="firstName" class="form-control" value="${manager.firstName != null ? manager.firstName : ''}"/>
                                            <span class="help-block error-text">${errors.firstName}</span>
                                        </div>
                                    </div>

                                    <!-- Last Name field -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Tên </label>
                                        <div class="col-md-6">
                                            <input type="text" name="lastName" class="form-control" value="${manager.lastName != null ? manager.lastName : ''}"/>
                                            <span class="help-block error-text">${errors.lastName}</span>
                                        </div>
                                    </div>

                                    <!-- Phone field -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Số điện thoại</label>
                                        <div class="col-md-6">
                                            <input type="text" name="phone" class="form-control" value="${manager.phone != null ? manager.phone : ''}"/>
                                            <span class="help-block error-text">${errors.phone}</span>
                                        </div>
                                    </div>

                                    <!-- Branch Selection -->
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">Chi nhánh <span class="required">*</span></label>
                                        <div class="col-md-6">
                                            <select name="branchId" class="form-control select2">
                                                <option value="">-- Chọn chi nhánh --</option>
                                                <c:forEach items="${branches}" var="branch">
                                                    <option value="${branch.id}" ${manager.branchId == branch.id ? 'selected' : ''}>
                                                            ${branch.name}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <span class="help-block error-text">${errors.branchId}</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Form Actions -->
                                <div class="form-actions">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            <button type="submit" class="btn btn-primary">
                                                <i class="fa fa-check"></i> Lưu
                                            </button>
                                            <a href="/admin/accounts/managers" class="btn btn-default">
                                                <i class="fa fa-times"></i> Hủy
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script>
    $(document).ready(function() {
        // Initialize Select2 for better dropdown experience
        $('.select2').select2();

        // Form validation
        $('.form-horizontal').validate({
            errorElement: 'span',
            errorClass: 'help-block error-text',
            rules: {
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: ${empty manager.email}, // Only required if no email (new manager)
                    minlength: 8
                },
                confirmPassword: {
                    required: ${empty manager.email}, // Only required if no email (new manager)
                    equalTo: '[name="password"]'
                },
                firstName: {
                    required: false
                },
                lastName: {
                    required: false
                },
                phone: {
                    required: false,
                    minlength: 9,
                },
                branchId: {
                    required: true
                }
            },
            messages: {
                email: {
                    required: "Vui lòng nhập email",
                    email: "Email không hợp lệ"
                },
                password: {
                    required: "Vui lòng nhập mật khẩu",
                    minlength: "Mật khẩu phải có ít nhất 8 ký tự"
                },
                confirmPassword: {
                    required: "Vui lòng xác nhận mật khẩu",
                    equalTo: "Mật khẩu không khớp"
                },
                firstName: "Vui lòng nhập họ",
                lastName: "Vui lòng nhập tên",
                phone: {
                    minlength: "Số điện thoại phải có ít nhất 9 chữ số"
                },
                branchId: "Vui lòng chọn chi nhánh"
            }
        });
    });
</script>
</body>
</html>
