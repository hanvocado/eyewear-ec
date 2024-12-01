package com.eyewear.controllers.buyer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/buyer")
public class ProfileController {

    @GetMapping("/profile")
    public String showProfile() {
        return "buyer/profile";
    }
}