package com.eyewear.controllers.user;

import com.eyewear.DTO.request.ApiResponse;
import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.DTO.request.UserUpdateRequest;
import com.eyewear.entities.User;
import com.eyewear.services.UserService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/register")
    ApiResponse<User> createUser(@RequestBody @Valid UserCreationRequest request){
        ApiResponse<User> apiResponse = new ApiResponse<>();

        apiResponse.setResult(userService.createRequest(request));

        return apiResponse;
    }

    @GetMapping("/myInfo")
    User getMyInfo() {
        return userService.getMyInfo();
    }

    @GetMapping("/getUsers")
    List<User> getUsers() {
        return userService.getUsers();
    }

    @GetMapping("/{userId}")
    User getUser(@PathVariable("userId") String userId) {
        return userService.getUser(userId);
    }

    @GetMapping("/email/{userEmail}")
    User getUserByEmail(@PathVariable("userEmail") String userEmail) {
        return userService.getUserByEmail(userEmail);
    }

    @PutMapping("/{userId}")
    User updateUser(@RequestBody UserUpdateRequest request, @PathVariable String userId) {
        return userService.updateUser(userId, request);
    }

    @DeleteMapping("/{userId}")
    String deleteUser(@PathVariable("userId") String userId) {
        userService.deleteUser(userId);
        return "User has been deleted";
    }
}
