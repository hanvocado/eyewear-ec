package com.eyewear.controllers;

import com.eyewear.DTO.request.ApiResponse;
import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.entities.User;
import com.eyewear.services.UserService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class RegisterController {
    private UserService userService;

    @GetMapping("register")
    public String registedPage() {
        return "register";
    }

}