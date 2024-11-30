package com.eyewear.configs;

import com.eyewear.entities.User;
import com.eyewear.repositories.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.io.IOException;
import java.util.Optional;
import java.util.Set;

@Configuration
public class CustomSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
    private UserRepository userRepo;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		// Lưu user vào session
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        String email = userDetails.getUsername();
        
        // Lấy user từ database
        Optional<User> user = userRepo.findByEmail(email);
        
        // Lưu vào session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);
        session.setAttribute("email", email);
        session.setMaxInactiveInterval(30 * 60); // 30 phút
		
		
		
		
		
		Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());

		if (roles.contains("ROLE_MANAGER")) {
			response.sendRedirect("/manager/");
		} else if (roles.contains("ROLE_BUYER")) {
			response.sendRedirect("/");
		} else if (roles.contains("ROLE_ADMIN")) {
			response.sendRedirect("/admin/");
		} else {
			response.sendRedirect("/access-denied");
		}

	}

}
