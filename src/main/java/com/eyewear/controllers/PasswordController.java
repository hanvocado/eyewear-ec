package com.eyewear.controllers;

import com.eyewear.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/password")
public class PasswordController {

    @Autowired
    private UserService userService;

    @PostMapping("/forgot")
    public void forgotPassword(@RequestParam String email) {
        userService.createPasswordResetToken(email);
    }

    @PostMapping("/reset")
    public void resetPassword(@RequestParam String token, @RequestParam String newPassword) {
        userService.resetPassword(token, newPassword);
    }

    @GetMapping("/validate")
    public boolean validateToken(@RequestParam String token) {
        return userService.validatePasswordResetToken(token);
    }
}