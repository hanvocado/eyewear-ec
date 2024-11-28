package com.eyewear.controllers.manager;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ManagerHomeController {
	@RequestMapping("/manager")
	public String home() {
		return "manager/home";
	}
	@GetMapping("/manager")
	public ResponseEntity<String> testManager(HttpServletRequest request) {
		String authHeader = request.getHeader("Authorization");
		System.out.println("Authorization Header: " + authHeader);
		return ResponseEntity.ok("Test Manager Endpoint");
	}

}
