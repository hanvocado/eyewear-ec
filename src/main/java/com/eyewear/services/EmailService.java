package com.eyewear.services;

import jakarta.mail.MessagingException;

public interface EmailService {
    void sendResetPasswordEmail(String to, String token) throws MessagingException;
}