package com.eyewear.controllers.buyer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/buyer/booking")
public class BookingController {
	
	@GetMapping("")
	public String bookingView() {
		return "buyer/booking";
	}
}
