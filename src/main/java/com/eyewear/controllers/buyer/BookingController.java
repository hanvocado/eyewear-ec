package com.eyewear.controllers.buyer;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.Address;
import com.eyewear.entities.Appointment;
import com.eyewear.entities.Branch;
import com.eyewear.entities.Buyer;
import com.eyewear.services.AppointmentService;
import com.eyewear.services.BranchService;
import com.eyewear.services.BuyerService;
import com.eyewear.utils.DateTimeProcessing;
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
		
		List<String> appointmentOpts = appointmentService.getFormattedAppointmentsScheduled();

		List<ServiceType> services = Arrays.asList(ServiceType.values());

		model.addAttribute("buyer", buyer);
		model.addAttribute("branchs", branchs);
		model.addAttribute("services", services);
        model.addAttribute("appointmentOpts", appointmentOpts);

		return "buyer/booking";
	}

	@PostMapping()
	public String bookingAppointment(Model model,
			@RequestParam(value = "appointmentType") String appointmentType,
			@RequestParam(value = "appointmentTime", required = false) String appointmentTime,
			@RequestParam(value = "customDate", required = false) String customDate,
			@RequestParam(value = "customStartTime", required = false) String customStartTime,
			@RequestParam(value = "customEndTime", required = false) String customEndTime,
			@RequestParam(value = "selectedServices", required = false) List<String> services,
			@RequestParam(value = "message", required = false) String message,
			@RequestParam(value = "branchId") Long branchId,
			Principal principal, RedirectAttributes redirectAttributes) {

		DateTimeProcessing dtProcess = new DateTimeProcessing();
		LocalDateTime[] appointmentTimes = dtProcess.getAppointmentTimes(
                appointmentType, appointmentTime, customDate, customStartTime, customEndTime);

        LocalDateTime startDateTime = appointmentTimes[0];
        LocalDateTime endDateTime = appointmentTimes[1];

	    Long buyerId = getCurrentBuyerId(principal);
	    
	    boolean success = appointmentService.bookAppointment(
                startDateTime, endDateTime, message, services, buyerId, branchId);
	    
	    if (success) {
	    	redirectAttributes.addFlashAttribute("message", "Đặt lịch thành công!");
	    	redirectAttributes.addFlashAttribute("messageType", "success");
		} else {
			redirectAttributes.addFlashAttribute("message", "Đặt lịch thất bại!");
			redirectAttributes.addFlashAttribute("messageType", "danger");
		}

		return "buyer/booking";
	}

	private Long getCurrentBuyerId(Principal principal) {
		return 1L;
	}

}
