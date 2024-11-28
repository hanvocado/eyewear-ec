package com.eyewear.controllers;

import com.eyewear.DTO.request.ApiResponse;
import com.eyewear.DTO.request.AuthenticationRequest;
import com.eyewear.DTO.request.IntrospectRequest;
import com.eyewear.repositories.AuthenticationResponse;
import com.eyewear.repositories.IntrospectResponse;
import com.eyewear.services.AuthenticationService;
import com.nimbusds.jose.JOSEException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthenticationController {
    AuthenticationService authenticationService;

    @PostMapping(path = "/login")
    ApiResponse<AuthenticationResponse> authenticate(@RequestBody AuthenticationRequest request){
        var result = authenticationService.authenticate(request);
        return ApiResponse.<AuthenticationResponse>builder()
                .result(result)
                .build();
    }

    @PostMapping("/introspect")
    ApiResponse<IntrospectResponse> authenticate(@RequestBody IntrospectRequest request) throws ParseException, JOSEException {
        var result = authenticationService.introspect(request);
        return ApiResponse.<IntrospectResponse>builder()
                .result(result)
                .build();
    }
    @GetMapping("/protected-resource")
    public ResponseEntity<?> getProtectedResource() {
        // Lấy thông tin người dùng từ token
        return ResponseEntity.ok("Welcome , you have accessed a protected resource!");
    }
}
