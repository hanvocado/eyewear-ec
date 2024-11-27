package com.eyewear.services.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.DTO.request.UserUpdateRequest;
import com.eyewear.entities.User;
import com.eyewear.enums.Role;
import com.eyewear.exceptions.AppException;
import com.eyewear.exceptions.ErrorCode;
import com.eyewear.model.ResetPasswordToken;
import com.eyewear.repositories.PasswordResetTokenRepository;
import com.eyewear.repositories.UserRepository;
import com.eyewear.services.EmailService;
import com.eyewear.services.UserService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;


@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    public User createRequest(UserCreationRequest request) {
        User user = new User();

        if(userRepository.existsByEmail(request.getEmail())) {
            throw new AppException(ErrorCode.EMAIL_EXISTED);
        }

        user.setEmail(request.getEmail());

        user.setPassword(passwordEncoder.encode(request.getPassword()));

        user.setPhone(request.getPhone());
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setAddress(request.getAddress());
        user.setRoles(Role.BUYER.name());

        return userRepository.save(user);
    }

    public User getMyInfo(){
        var context = SecurityContextHolder.getContext();
        String email = context.getAuthentication().getName();

        User user = userRepository.findByEmail(email).orElseThrow(
                () -> new AppException(ErrorCode.USER_NOT_EXISTED));

        return user;
    }

    @Override
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @Override
    public User getUser(String id) {
        return userRepository.findById(id).orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng!"));
    }

    @Override
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng!"));
    }

    @Override
    public User updateUser(String id, UserUpdateRequest request) {
        User user = getUser(id);

        user.setPassword(request.getPassword());
        user.setPhone(request.getPhone());
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setAddress(request.getAddress());
        user.setRoles(Role.MANAGER.name());
        return userRepository.save(user);
    }

    @Override
    public void deleteUser(String id) {
        userRepository.deleteById(id);
    }


    @Override
    public void resetPassword(String email) {
        Optional<User> userOptional = userRepository.findByEmail(email);
        if (!userOptional.isPresent()) {
            throw new IllegalArgumentException("Email không hợp lệ");
        }

        User user = userOptional.get();
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
        User user = resetToken.getUser();
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);

        passwordResetTokenRepository.delete(resetToken);
    }
}