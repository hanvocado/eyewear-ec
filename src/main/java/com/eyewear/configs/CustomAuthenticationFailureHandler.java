package com.eyewear.configs;

import jakarta.servlet.ServletException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(jakarta.servlet.http.HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        // Thiết lập thông báo lỗi vào session
        request.getSession().setAttribute("error", "Email hoặc mật khẩu không đúng. Vui lòng thử lại.");
        // Giữ lại thông tin đã nhập để tránh người dùng phải nhập lại
        String email = request.getParameter("username");
        request.getSession().setAttribute("email", email);
        // Chuyển hướng lại trang đăng nhập với thông báo lỗi
        response.sendRedirect("/login");
    }
}
