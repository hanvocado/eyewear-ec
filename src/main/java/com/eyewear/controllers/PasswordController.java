package com.eyewear.controllers;

import com.eyewear.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class PasswordController {

    @Autowired
    private UserService userService;

    @GetMapping("/forgot_password_page")
    public String showForgotPasswordForm() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPasswordForm(@RequestParam("email") String email, Model model) {
        try {
            userService.resetPassword(email);
            model.addAttribute("message", "Email đã được gửi để đặt lại mật khẩu.");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "forgot-password";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(@RequestParam("token") String token, Model model) {
        model.addAttribute("token", token);
        return "reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPasswordForm(@RequestParam("token") String token,
                                           @RequestParam("password") String password,
                                           @RequestParam("confirmPassword") String confirmPassword,
                                           Model model) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp.");
            return "reset-password";
        }

        try {
            userService.updatePassword(token, password);
            model.addAttribute("message", "Mật khẩu đã được cập nhật thành công.");
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
        }
        return "reset-password";
    }
}