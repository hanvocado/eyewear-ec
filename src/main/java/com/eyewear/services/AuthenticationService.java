package com.eyewear.services;

import com.eyewear.DTO.request.AuthenticationRequest;
import com.eyewear.DTO.request.IntrospectRequest;
import com.eyewear.entities.User;
import com.eyewear.repositories.AuthenticationResponse;
import com.eyewear.repositories.IntrospectResponse;
import com.nimbusds.jose.JOSEException;

public interface AuthenticationService {
    public AuthenticationResponse authenticate(AuthenticationRequest request);
    public IntrospectResponse introspect(IntrospectRequest request) throws JOSEException, ParseException;
    String generateToken(User user);
}
