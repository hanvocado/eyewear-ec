package com.eyewear.DTO.request;

public class AuthResponse {

    private String jwt;

    public AuthResponse(String jwt) {
        this.jwt = jwt;
    }

    public String getJwt() {
        return jwt;
    }
}