package com.eyewear.controllers;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@Controller
public class HomeController {

	@GetMapping("/")
	public String index() {
		log.info("Accessing root path /");
		return "redirect:/login_page";
	}
}