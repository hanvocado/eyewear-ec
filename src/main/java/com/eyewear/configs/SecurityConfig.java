package com.eyewear.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // Vô hiệu hóa CSRF bảo mật cho mục đích thử nghiệm
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/forgot-password", "/reset-password", "/h2-console/**", "/**").permitAll() // Cho phép các đường dẫn cụ thể và tất cả các đường dẫn khác
                        .anyRequest().authenticated()
                )
                .headers(headers -> headers.frameOptions().disable()); // Vô hiệu hóa frameOptions để H2 Console hoạt động

        return http.build();
    }
}