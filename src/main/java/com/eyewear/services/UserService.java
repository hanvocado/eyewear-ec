package com.eyewear.services;

public interface UserService {
    void resetPassword(String email);
    void updatePassword(String token, String newPassword);
}