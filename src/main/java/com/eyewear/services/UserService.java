package com.eyewear.services;

import com.eyewear.model.User;

public interface UserService {
    void createPasswordResetToken(String email);

    boolean validatePasswordResetToken(String token);

    boolean resetPassword(String token, String newPassword);
}