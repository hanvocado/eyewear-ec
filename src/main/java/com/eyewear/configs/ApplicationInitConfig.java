package com.eyewear.configs;

import com.eyewear.entities.User;
import com.eyewear.enums.Role;
import com.eyewear.repositories.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ApplicationInitConfig {

    PasswordEncoder passwordEncoder;

    @Bean
    ApplicationRunner applicationRunner(UserRepository userRepository) {
        return args -> {
            if (userRepository.findByEmail("admin@eyewear.com").isEmpty()){

                User user = User.builder()
                        .email("admin@eyewear.com")
                        .password(passwordEncoder.encode("admin"))
                        .roles(Role.ADMIN.name())
                        .build();

                userRepository.save(user);
                log.warn("Người dùng Admin đã được tạo với mật khẩu mặc định, vui lòng đổi mật khẩu!");
            }
        };
    }
}
