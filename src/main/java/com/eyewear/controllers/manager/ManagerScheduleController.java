package com.eyewear.controllers.manager;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eyewear.entities.Appointment;
import com.eyewear.services.AppointmentService;
import com.eyewear.utils.AppointmentStatus;

@Controller
@RequestMapping("/manager/schedule")
public class ManagerScheduleController {

	@Autowired
	private AppointmentService appointmentService;

	@GetMapping("/calendar")
	public String calendar() {
		return "/manager/schedule-calendar";
	}

	@GetMapping("/request")
	public String request(Model model, Principal principal) {
		Long branchId = 1L;
	
		List<Appointment> pendingAppointments = appointmentService.getAppointmentsByStatusAndBranch(AppointmentStatus.PENDING.name(), branchId);
		model.addAttribute("appointments", pendingAppointments);
		return "/manager/schedule-request";
	}
	
	@PostMapping("/update-status")
    public String updateStatus(@RequestParam Long appointmentId, @RequestParam String status, Model model) {
        appointmentService.updateStatus(appointmentId, status);
        return "redirect:/manager/schedule/request"; 
    }

	@GetMapping("/list")
	public String list(Model model, Principal principal) {
		Long branchId = 1L;
		
		List<Appointment> upcomingAppointments = appointmentService.getUpcomingAppointments(branchId);
		List<Appointment> onProgressAppointments = appointmentService.getOnProgressAppointments(branchId);
		List<Appointment> finishedAppointments = appointmentService.getFinishedAppointments(branchId);
		List<Appointment> allAppointments = appointmentService.getAllAppointments(branchId);
		List<Appointment> scheduledAppointments = appointmentService.getAppointmentsByStatusAndBranch("SCHEDULED", branchId);

		model.addAttribute("upcomingAppointments", upcomingAppointments);
		model.addAttribute("onProgressAppointments", onProgressAppointments);
		model.addAttribute("finishedAppointments", finishedAppointments);
		model.addAttribute("allAppointments", allAppointments);
		model.addAttribute("scheduledAppointments", scheduledAppointments);

		return "/manager/schedule-list";
	}
	
	@RequestMapping("/calendar")
    @ResponseBody
    public List<Appointment> getAppointments() {
        return appointmentService.getCalendarAppointments();
    }

    @PostMapping("/add-appointment")
    @ResponseBody
    public Appointment addAppointment(@RequestBody Appointment appointment) {
        return appointmentService.addAppointment(appointment);
    }
	
}
