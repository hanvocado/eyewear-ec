package com.eyewear.controllers.manager;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eyewear.entities.Appointment;
import com.eyewear.entities.Branch;
import com.eyewear.model.EventModel;
import com.eyewear.services.AppointmentService;
import com.eyewear.services.BranchService;
import com.eyewear.utils.AppointmentStatus;

import ch.qos.logback.core.joran.util.beans.BeanUtil;
import net.minidev.json.writer.BeansMapper.Bean;

@Controller
@RequestMapping("/manager/schedule")
public class ManagerScheduleController {

	private static final Logger logger = LoggerFactory.getLogger(ManagerScheduleController.class);
	
	@Autowired
	private AppointmentService appointmentService;

	@Autowired
	private BranchService branchService;

	@GetMapping("/calendar")
	public String calendar() {
		return "/manager/schedule-calendar";
	}

	@GetMapping("/request")
	public String request(Model model, Principal principal) {
		Long branchId = 1L;

		List<Appointment> pendingAppointments = appointmentService
				.getAppointmentsByStatusAndBranch(AppointmentStatus.PENDING.name(), branchId);
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
		List<Appointment> scheduledAppointments = appointmentService.getAppointmentsByStatusAndBranch("SCHEDULED",
				branchId);

		model.addAttribute("upcomingAppointments", upcomingAppointments);
		model.addAttribute("onProgressAppointments", onProgressAppointments);
		model.addAttribute("finishedAppointments", finishedAppointments);
		model.addAttribute("allAppointments", allAppointments);
		model.addAttribute("scheduledAppointments", scheduledAppointments);

		return "/manager/schedule-list";
	}

	@GetMapping("/calendar-appointments")
	public ResponseEntity<List<Appointment>> getAppointments() {
		Long branchId = 1L;
		List<String> statuses = Arrays.asList("APPROVED", "SCHEDULED");
		List<Appointment> apts = appointmentService.getAppointmentsByStatus(statuses, branchId);
		logger.info("Appointments fetched: {}", apts.size());
		return ResponseEntity.ok(apts);
	}

	@PostMapping("/save")
	public ResponseEntity<Appointment> saveAppointment(@RequestBody Appointment apt) {
		Long branchId = 1L;
		if (apt.getBranch() == null) {
			apt.setBranch(new Branch());
		}
		apt.getBranch().setId(branchId);
		Appointment savedAppointment = appointmentService.save(apt);
		return ResponseEntity.ok(savedAppointment);
	}

	@PostMapping("/delete")
	public ResponseEntity<Void> deleteAppointment(@RequestBody Map<String, Long> payload) {
	    Long appointmentId = payload.get("id");
	    appointmentService.deleteAppointment(appointmentId);
	    return ResponseEntity.ok().build();
	}

}
