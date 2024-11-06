package com.eyewear.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ManagerHomeController {
	@RequestMapping("/manager")
	public String home() {
		return "manager/home";
	}

}
