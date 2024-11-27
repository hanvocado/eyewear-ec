package com.eyewear.services;

import com.eyewear.dto.request.AuthenticationRequest;
import com.eyewear.dto.request.IntrospectRequest;
import com.eyewear.entities.User;
import com.eyewear.repositories.AuthenticationResponse;
import com.eyewear.repositories.IntrospectResponse;
import com.nimbusds.jose.JOSEException;

import java.text.ParseException;

public interface AuthenticationService {
    public AuthenticationResponse authenticate(AuthenticationRequest request);
    public IntrospectResponse introspect(IntrospectRequest request) throws JOSEException, ParseException;
    String generateToken(User user);
}
