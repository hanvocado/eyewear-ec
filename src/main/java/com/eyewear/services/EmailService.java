package com.eyewear.services;

public interface EmailService {
    void sendResetPasswordEmail(String to, String token);
}