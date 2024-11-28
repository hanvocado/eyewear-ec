package com.eyewear.controllers;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LoginController {

    // Hiển thị trang đăng nhập
    @GetMapping("login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("user/profile")
    public String profilePage() {
        return "buyer/order-detail";
    }

}