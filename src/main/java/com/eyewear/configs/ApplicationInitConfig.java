package com.eyewear.configs;

import com.eyewear.entities.Admin;
import com.eyewear.entities.Manager;
import com.eyewear.entities.Branch;
import com.eyewear.repositories.BranchRepository;

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
	BranchRepository branchRepository;

	@Bean
	ApplicationRunner applicationRunner(UserRepository userRepository) {
		return args -> {
			if (userRepository.findByEmail("admin@eyewear.com").isEmpty()) {

				Admin ad = Admin.builder()
						.email("admin@eyewear.com")
						.password(passwordEncoder.encode("admin"))
						.build();

				userRepository.save(ad);
				log.warn("Người dùng Admin đã được tạo với mật khẩu mặc định, vui lòng đổi mật khẩu!");
			}

			if (userRepository.findByEmail("manager1@eyewear.com").isEmpty()) {

				Manager ma1 = Manager.builder()
						.email("manager1@eyewear.com")
						.password(passwordEncoder.encode("12345"))
						//.branchId((long) 1)
						.build();

				userRepository.save(ma1);
				log.warn("Người dùng manager đã được tạo với mật khẩu mặc định, vui lòng đổi mật khẩu!");
			}
			
			if (userRepository.findByEmail("manager2@eyewear.com").isEmpty()) {

				Manager ma2 = Manager.builder()
						.email("manager2@eyewear.com")
						.password(passwordEncoder.encode("12345"))
						//.branchId((long) 2)
						.build();

				userRepository.save(ma2);
				log.warn("Người dùng manager đã được tạo với mật khẩu mặc định, vui lòng đổi mật khẩu!");
			}

			if (branchRepository.findByName("Hồ Chí Minh").isEmpty()) {
				Branch branchHCM = new Branch();
				branchHCM.setName("Hồ Chí Minh");
				branchRepository.save(branchHCM);
				log.info("Branch Hồ Chí Minh đã được tạo.");
			}

			if (branchRepository.findByName("Hà Nội").isEmpty()) {
				Branch branchHN = new Branch();
				branchHN.setName("Hà Nội");
				branchRepository.save(branchHN);
				log.info("Branch Hà Nội đã được tạo.");
			}
		};
	}
}
