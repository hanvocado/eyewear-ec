package com.eyewear.services;

import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.DTO.request.UserUpdateRequest;
import com.eyewear.entities.User;

import java.util.List;

public interface UserService {
    User createRequest(UserCreationRequest request);

    public List<User> getUsers();

    public User getUser(String id);

    public User getUserByEmail(String email);

    public User updateUser(String id, UserUpdateRequest request);

    public void deleteUser(String id);

    void resetPassword(String email);

    void updatePassword(String token, String newPassword);

    public User getMyInfo();
}