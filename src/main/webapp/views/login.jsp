<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<body id="default_theme" class="it_service">

<section class="py-3 py-md-5 py-xl-8">
    <div class="row margin-bottom-40">
    <div class="col-md-9 col-sm-9">
        <h1>Login</h1>
        <div class="content-form-page">
            <div class="row">
                <div class="col-md-7 col-sm-7">
                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${param.error}">
                        <div class="alert alert-danger text-center" role="alert">
                                ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"]}
                        </div>
                    </c:if>
                    <form action="/signin" method="post" class="form-horizontal form-without-legend" role="form">
                        <div class="form-group" >
                            <label for="username" class="col-lg-4 control-label">Email <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="email" id="username" name="username" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-lg-4 control-label">Password <span class="require">*</span></label>
                            <div class="col-lg-8">
                                <input type="password" id="password" name="password" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-4 padding-left-0">
                                <a href="/forgot_password_page">Forgot Password?</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-20">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8 col-md-offset-4 padding-left-0 padding-top-10 padding-right-30">
                                <hr>
                                <div class="login-socio">
                                    <p class="text-muted">or login using:</p>
                                    <ul class="social-icons">
                                        <li><a href="/login/oauth2/authorization/google" data-original-title="Google Plus" class="googleplus" title="Google Plus"></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>
</section>
</body>
</html>