package com.eyewear.configs;

import lombok.Builder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;

import javax.crypto.spec.SecretKeySpec;
import java.util.Arrays;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final String[] PUBLIC_ENPOINTS = {
            "/users/register", "/auth/login", "/auth/introspect"
    };

    protected static final String SIGNED_KEY =
            "drmCpY2RcIRQmD0LaU91BjToW+UnVnPKx1jFySEGthLEZz/lTvPXmzkJdHBwZIMn";

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {

        httpSecurity
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(request ->
                request
                        .requestMatchers(HttpMethod.POST, PUBLIC_ENPOINTS).permitAll()
                        .requestMatchers(HttpMethod.GET, "/users/myInfo").permitAll()
                        .requestMatchers("/users/**").hasAuthority("SCOPE_ADMIN")
                        .requestMatchers("/manager/**").hasAuthority("SCOPE_MANAGER")
                        .requestMatchers("/buyer/**").hasAuthority("SCOPE_BUYER")
                        .requestMatchers("/**").permitAll()
                        .anyRequest().authenticated()
                )
        ;

        httpSecurity.oauth2ResourceServer(oauth2 ->
                oauth2.jwt(jwtConfigurer ->
                        jwtConfigurer.decoder(jwtDecoder()))
                );

        return httpSecurity.build();
    }

    @Bean
    JwtDecoder jwtDecoder() {
        SecretKeySpec secretKeySpec = new SecretKeySpec(SIGNED_KEY.getBytes(), "HmacSHA256");
        return NimbusJwtDecoder
                .withSecretKey(secretKeySpec)
                .macAlgorithm(MacAlgorithm.HS512)
                .build();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }

}
