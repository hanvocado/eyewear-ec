package com.eyewear.services.impl;

import com.eyewear.model.ResetPasswordToken;
import com.eyewear.model.Users;
import com.eyewear.repositories.PasswordResetTokenRepository;
import com.eyewear.repositories.UserRepository;
import com.eyewear.services.UserService;
import com.eyewear.services.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;



    @Override
    public void resetPassword(String email) {
        Optional<Users> userOptional = userRepository.findByEmail(email);
        if (!userOptional.isPresent()) {
            throw new IllegalArgumentException("Email không hợp lệ");
        }

        Users user = userOptional.get();
        String token = UUID.randomUUID().toString();
        ResetPasswordToken resetToken = new ResetPasswordToken(token, user, LocalDateTime.now().plusMinutes(5));
        passwordResetTokenRepository.save(resetToken);

        emailService.sendResetPasswordEmail(user.getEmail(), token);
    }

    @Override
    public void updatePassword(String token, String newPassword) {
        Optional<ResetPasswordToken> resetTokenOptional = passwordResetTokenRepository.findByToken(token);
        if (!resetTokenOptional.isPresent() || resetTokenOptional.get().isExpired()) {
            throw new IllegalArgumentException("Liên kết đã hết hạn");
        }

        ResetPasswordToken resetToken = resetTokenOptional.get();
        Users user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        passwordResetTokenRepository.delete(resetToken);
    }
}