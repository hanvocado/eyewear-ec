package com.eyewear.controllers.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manager/schedule")
public class ManagerScheduleController {

	@GetMapping("/calendar")
	public String calendar() {
		return "/manager/schedule-calendar";
	}
	
	@GetMapping("/progress")
	public String progress() {
		return "/manager/schedule-progress";
	}
}
