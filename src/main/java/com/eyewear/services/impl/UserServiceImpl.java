package com.eyewear.services.impl;

import com.eyewear.model.ResetPasswordToken;
import com.eyewear.model.User;
import com.eyewear.repositories.PasswordResetTokenRepository;
import com.eyewear.repositories.UserRepository;
import com.eyewear.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordResetTokenRepository tokenRepository;

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void createPasswordResetToken(String email) {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            String token = UUID.randomUUID().toString();
            ResetPasswordToken resetToken = new ResetPasswordToken(token, user);
            tokenRepository.save(resetToken);
            sendResetEmail(user.getEmail(), token);
        }
    }

    @Override
    public boolean validatePasswordResetToken(String token) {
        ResetPasswordToken resetToken = tokenRepository.findByToken(token);
        return resetToken != null && !resetToken.isExpired();
    }

    @Override
    public boolean resetPassword(String token, String newPassword) {
        ResetPasswordToken resetToken = tokenRepository.findByToken(token);
        if (resetToken != null && !resetToken.isExpired()) {
            User user = resetToken.getUser();
            user.setPassword(newPassword);
            userRepository.save(user);
            tokenRepository.delete(resetToken);
            return true;
        }
        return false;
    }

    private void sendResetEmail(String email, String token) {
        String resetLink = "http://localhost:8080/password/reset?token=" + token;
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Password Reset Request");
        message.setText("To reset your password, click the link below:\n" + resetLink);
        mailSender.send(message);
    }
}