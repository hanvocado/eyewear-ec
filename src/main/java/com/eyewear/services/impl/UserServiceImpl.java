package com.eyewear.services.impl;

import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.DTO.request.UserUpdateRequest;
import com.eyewear.entities.*;
import com.eyewear.model.ResetPasswordToken;
import com.eyewear.repositories.*;
import com.eyewear.services.EmailService;
import com.eyewear.services.UserService;
import com.eyewear.exceptions.AppException;
import com.eyewear.exceptions.ErrorCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import jakarta.mail.MessagingException;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BranchRepository branchRepository;

    @Autowired
    private PasswordResetTokenRepository passwordResetTokenRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    @Override
    public User createRequest(UserCreationRequest request) {
        Buyer user = new Buyer();

        if (userRepository.existsByEmail(request.getEmail())) {
            throw new AppException(ErrorCode.EMAIL_EXISTED);
        }

        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setPhone(request.getPhone());
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());

        return userRepository.save(user);
    }

    @Override
    public User getMyInfo() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));
    }

    @Override
    public List<User> getUsers() {
        return userRepository.findAll();
    }

    @Override
    public User getUser(String id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng!"));
    }

    @Override
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng!"));
    }

    @Override
    public User updateUser(String id, UserUpdateRequest request) {
        Buyer user = (Buyer) getUser(id);

        user.setPassword(request.getPassword());
        user.setPhone(request.getPhone());
        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());

        return userRepository.save(user);
    }

    @Override
    public void deleteUser(String id) {
        userRepository.deleteById(id);
    }

    @Override
    public void resetPassword(String email) throws MessagingException {
        try {
            Optional<User> userOptional = userRepository.findByEmail(email);
            if (!userOptional.isPresent()) {
                throw new IllegalArgumentException("Email không hợp lệ");
            }

            User user = userOptional.get();
            String token = UUID.randomUUID().toString();
            ResetPasswordToken resetToken = new ResetPasswordToken(token, user, LocalDateTime.now().plusMinutes(5));
            passwordResetTokenRepository.save(resetToken);

            emailService.sendResetPasswordEmail(user.getEmail(), token);

        } catch (MessagingException e) {
            // Log the error
            throw new MessagingException("Error sending reset password email: " + e.getMessage());
        } catch (Exception e) {
            throw new RuntimeException("Error processing password reset: " + e.getMessage());
        }
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

    @Override
    public Long getCurrentBuyerId(Principal principal) {
        String username = principal.getName();

        // Tìm User theo email hoặc username để lấy ID
        User user = getUserByEmail(username);

        return user.getId();
    }

    @Override
    public List<Manager> findAllManagers() {
        return userRepository.findAllByType(Manager.class).stream()
                .map(user -> (Manager) user)
                .collect(Collectors.toList());
    }

    @Override
    public Buyer createBuyer(UserCreationRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("Email đã tồn tại trong hệ thống");
        }

        Buyer buyer = new Buyer();
        buyer.setEmail(request.getEmail());
        buyer.setPassword(passwordEncoder.encode(request.getPassword()));
        buyer.setPhone(request.getPhone());
        buyer.setFirstName(request.getFirstName());
        buyer.setLastName(request.getLastName());

        Address address = new Address();
        address.setStreetNumber(Integer.parseInt(request.getStreetNumber()));
        address.setStreetName(request.getStreetName());
        address.setCommue(request.getCommue());
        address.setDistrict(request.getDistrict());
        address.setProvince(request.getProvince());
        address.setBuyer(buyer);
        buyer.setAddress(address);

        return userRepository.save(buyer);
    }

    @Override
    public Buyer updateBuyer(String id, UserUpdateRequest request) {
        Buyer buyer = getBuyer(id);

        if (request.getPassword() != null) {
            buyer.setPassword(passwordEncoder.encode(request.getPassword()));
        }
        buyer.setPhone(request.getPhone());
        buyer.setFirstName(request.getFirstName());
        buyer.setLastName(request.getLastName());

        Address address = buyer.getAddress();
        if (address == null) {
            address = new Address();
            address.setBuyer(buyer);
        }

        address.setStreetNumber(Integer.parseInt(request.getStreetNumber()));
        address.setStreetName(request.getStreetName());
        address.setCommue(request.getCommue());
        address.setDistrict(request.getDistrict());
        address.setProvince(request.getProvince());
        buyer.setAddress(address);

        return userRepository.save(buyer);
    }

    @Override
    public void deleteBuyer(String id) {
        userRepository.deleteById(id);
    }

    @Override
    public Manager createManager(UserCreationRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new AppException(ErrorCode.EMAIL_EXISTED);
        }

        Manager manager = new Manager();
        manager.setEmail(request.getEmail());
        manager.setPassword(passwordEncoder.encode(request.getPassword()));
        manager.setPhone(request.getPhone());
        manager.setFirstName(request.getFirstName());
        manager.setLastName(request.getLastName());
        manager.setPicture(request.getPicture());

        // Set branch if branchId provided
        if (request.getBranchId() != null) {
            Branch branch = branchRepository.findById(request.getBranchId())
                    .orElseThrow(() -> new AppException(ErrorCode.BRANCH_NOT_FOUND));
            manager.setBranch(branch);
        }

        return userRepository.save(manager);
    }

    @Override
    public Manager updateManager(String id, UserUpdateRequest request) {
        Manager manager = (Manager) userRepository.findById(id)
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        // Check if the new email already exists in the system, excluding the current manager's email
        if (!manager.getEmail().equals(request.getEmail()) && userRepository.existsByEmail(request.getEmail())) {
            throw new AppException(ErrorCode.EMAIL_EXISTED);
        }

        manager.setEmail(request.getEmail());
        if (request.getPassword() != null) {
            manager.setPassword(passwordEncoder.encode(request.getPassword()));
        }
        manager.setPhone(request.getPhone());
        manager.setFirstName(request.getFirstName());
        manager.setLastName(request.getLastName());
        manager.setPicture(request.getPicture());

        // Update branch if branchId provided
        if (request.getBranchId() != null) {
            Branch branch = branchRepository.findById(request.getBranchId())
                    .orElseThrow(() -> new AppException(ErrorCode.BRANCH_NOT_FOUND));
            manager.setBranch(branch);
        }

        return userRepository.save(manager);
    }

    @Override
    public void deleteManager(String id) {
        userRepository.deleteById(id);
    }

    @Override
    public List<Buyer> findAllBuyers() {
        return userRepository.findAllByType(Buyer.class).stream()
                .map(user -> (Buyer) user)
                .collect(Collectors.toList());
    }

    @Override
    public Buyer getBuyer(String id) {
        return (Buyer) userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy người dùng"));
    }

    @Override
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }
}