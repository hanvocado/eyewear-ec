package com.eyewear.services;

import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.DTO.request.UserUpdateRequest;
import com.eyewear.entities.Buyer;
import com.eyewear.entities.Manager;
import com.eyewear.entities.User;
import java.security.Principal;
import java.util.List;
import jakarta.mail.MessagingException;

public interface UserService {
    User createRequest(UserCreationRequest request);

    List<User> getUsers();

    User getUser(String id);

    User getUserByEmail(String email);

    User updateUser(String id, UserUpdateRequest request);

    void deleteUser(String id);

    void resetPassword(String email) throws MessagingException;

    void updatePassword(String token, String newPassword);

    User getMyInfo();

    Long getCurrentBuyerId(Principal principal);

    List<Manager> findAllManagers();

    Buyer createBuyer(UserCreationRequest request);

    Buyer updateBuyer(String id, UserUpdateRequest request);

    void deleteBuyer(String id);

    Manager createManager(UserCreationRequest request);

    Manager updateManager(String id, UserUpdateRequest request);

    void deleteManager(String id);

    List<Buyer> findAllBuyers();

    Buyer getBuyer(String id);

    boolean emailExists(String email);
}