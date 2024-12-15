package com.eyewear.controllers;

import com.eyewear.DTO.request.AuthResponse;
import com.eyewear.DTO.request.UserRequest;
import com.eyewear.entities.Manager;
import com.eyewear.entities.User;
import com.eyewear.enums.Role;
import com.eyewear.services.JwtService;
import com.eyewear.services.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eyewear.DTO.request.AuthResponse;
import com.eyewear.DTO.request.UserRequest;
import com.eyewear.services.JwtService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

@Controller
@RequiredArgsConstructor
@RequestMapping("")
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class LoginController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService detailsService;

    @Autowired
    private JwtService jwtService;
    
    @Autowired 
    private UserService userService;

    // Hiển thị trang đăng nhập
    @PostMapping("/login")
    public ResponseEntity<?> createAuthenticationToken(@RequestBody UserRequest authRequest, HttpSession session) throws Exception {
       try {
           authenticationManager.authenticate(
                   new UsernamePasswordAuthenticationToken(authRequest.getEmail(), authRequest.getPassword()));
       } catch (BadCredentialsException e) {
           throw new Exception("Incorrect username or password", e);
       }

       UserDetails userDetails = detailsService.loadUserByUsername(authRequest.getEmail());
       final String jwt = jwtService.generateToken(userDetails.getUsername());
       
       User user = userService.getUserByEmail(authRequest.getEmail());
       session.setAttribute("userId", user.getId());

       return ResponseEntity.ok(new AuthResponse(jwt));
    }

    @GetMapping("/login_page")
    public String profilePage() {
        return "login";
    }

}