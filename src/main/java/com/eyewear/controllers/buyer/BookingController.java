package com.eyewear.controllers.buyer;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.eyewear.entities.Address;
import com.eyewear.entities.Branch;
import com.eyewear.entities.Buyer;
import com.eyewear.services.AppointmentService;
import com.eyewear.services.BranchService;
import com.eyewear.services.BuyerService;
import com.eyewear.utils.ServiceType;

@Controller
@RequestMapping("/buyer/booking")
public class BookingController {

	@Autowired
	private BranchService branchService;

	@Autowired
	private BuyerService buyerService;
	
	@Autowired
	private AppointmentService appointmentService;

	@GetMapping()
	public String bookingView(Model model, Principal principal) {
		Long buyerId = getCurrentBuyerId(principal);
		Buyer buyer = buyerService.findById(buyerId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy buyer với ID: " + buyerId));

		List<Branch> branchs = branchService.findAll();

		List<ServiceType> services = Arrays.asList(ServiceType.values());

		model.addAttribute("buyer", buyer);
		model.addAttribute("branchs", branchs);
		model.addAttribute("services", services);

		return "buyer/booking";
	}

	@PostMapping("")
    public String createAppointment(@RequestParam("branchId") Long branchId,
                                    @RequestParam("from") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime from,
                                    @RequestParam("to") @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm") LocalDateTime to,
                                    @RequestParam("message") String message,
                                    @RequestParam(value = "services", required = false) List<String> services,
                                    Principal principal) {

        if (services != null && !services.isEmpty()) {
            String servicesString = String.join(", ", services);

            Long buyerId = getCurrentBuyerId(principal);
//            appointmentService.createAppointment(buyerId, branchId, from, to, message, servicesString);
        }

        return "redirect:/appointments/success";
    }

	private Long getCurrentBuyerId(Principal principal) {
		return 1L;
	}

}
