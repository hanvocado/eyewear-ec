package com.eyewear.configs;

import com.eyewear.filter.JwtAuthenticationFilter;
import jakarta.servlet.Filter;
import lombok.Builder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;


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
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .authorizeHttpRequests(request ->
                request
                        .requestMatchers(HttpMethod.POST, PUBLIC_ENPOINTS).permitAll()
                        .requestMatchers(HttpMethod.GET, "/users/myInfo").permitAll()
                        .requestMatchers (new AntPathRequestMatcher("/js/**")). permitAll()
                        .requestMatchers("/users/**").hasRole("ADMIN")
                        .requestMatchers("/manager/**").hasRole("MANAGER")
                        .requestMatchers("/buyer/**").hasRole("BUYER")
                        .requestMatchers("/**").permitAll()
                        .anyRequest().authenticated()
                )
//                .sessionManagement(management -> management
//                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS))
//                .addFilterBefore(jwtAuthenticationFilter(jwtDecoder()), UsernamePasswordAuthenticationFilter.class);
        ;

        httpSecurity.oauth2ResourceServer(oauth2 ->
                oauth2.jwt(jwtConfigurer ->
                        jwtConfigurer
                                .jwtAuthenticationConverter(jwtAuthenticationConverter())
                                .decoder(jwtDecoder())
                                  // Sử dụng bộ chuyển đổi quyền
                )
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
    public JwtAuthenticationFilter jwtAuthenticationFilter(JwtDecoder jwtDecoder) {
        return new JwtAuthenticationFilter(jwtDecoder); // Tạo bộ lọc JWT
    }

    @Bean
    JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
        JwtGrantedAuthoritiesConverter authoritiesConverter = new JwtGrantedAuthoritiesConverter();

        // Cấu hình tiền tố cho quyền (ví dụ "SCOPE_" cho các quyền)
        authoritiesConverter.setAuthoritiesClaimName("scope");
        authoritiesConverter.setAuthorityPrefix("ROLE_");
        converter.setJwtGrantedAuthoritiesConverter(authoritiesConverter);
        converter.setJwtGrantedAuthoritiesConverter(jwt -> {
            // Log ra tất cả các claim trong JWT
            Logger logger = LoggerFactory.getLogger(JwtAuthenticationConverter.class);
            jwt.getClaims().forEach((key, value) -> {
                logger.info("JWT Claim: {} = {}", key, value);  // In tất cả các claim
            });

            // Truy xuất quyền (authorities) từ claim "scope" và log
            if (jwt.getClaimAsStringList("scope") != null) {
                jwt.getClaimAsStringList("scope").forEach(scope -> {
                    logger.info("User has scope: {}", scope);
                });
            }

            // Trả về authorities từ claim "scope"
            return authoritiesConverter.convert(jwt);
        });

        return converter;
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:8080")); // Địa chỉ cho phép
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE")); // Các phương thức cho phép
        configuration.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type"));
        configuration.setExposedHeaders(Arrays.asList("Authorization")); // Nếu cần trả về header Authorization
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

}
