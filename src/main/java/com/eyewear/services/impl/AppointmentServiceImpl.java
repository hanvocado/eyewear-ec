package com.eyewear.services.impl;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.management.RuntimeErrorException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Appointment;
import com.eyewear.entities.Branch;
import com.eyewear.entities.Buyer;
import com.eyewear.repositories.AppointmentRepository;
import com.eyewear.repositories.BranchRepository;
import com.eyewear.repositories.BuyerRepository;
import com.eyewear.services.AppointmentService;
import com.eyewear.utils.AppointmentStatus;

@Service
public class AppointmentServiceImpl implements AppointmentService {

	@Autowired
	private AppointmentRepository appointmentRepo;

	@Autowired
	private BuyerRepository buyerRepository;

	@Autowired
	private BranchRepository branchRepository;

	@Override
	public boolean bookAppointment(LocalDateTime startDateTime, LocalDateTime endDateTime, String message,
			List<String> services, Long buyerId, Long branchId) {

		try {
			Buyer buyer = buyerRepository.findById(buyerId).orElseThrow(() -> new RuntimeException("Buyer not found"));

			Branch branch = branchRepository.findById(branchId)
					.orElseThrow(() -> new RuntimeException("Branch not found"));

			String status = AppointmentStatus.PENDING.name();

			Appointment appointment = Appointment.builder().start(startDateTime).end(endDateTime)
					.createdAt(LocalDateTime.now()).message(message).status(status).services(services).buyer(buyer)
					.branch(branch).build();

			appointmentRepo.save(appointment);
			return true;
		} catch (Exception e) {
			System.err.println("Lỗi khi đặt lịch: " + e.getMessage());
			return false;
		}
	}

	@Override
	public List<String> getFormattedAppointmentsScheduled() {
		return appointmentRepo.findFormattedAppointmentsByStatus("SCHEDULED");
	}

	@Override
	public List<Appointment> getAppointmentsByStatusAndBranch(String status, Long branchId) {
		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		return appointmentRepo.findByStatusAndBranch(status, branch);
	}

	@Override
	public void updateStatus(Long appointmentId, String status) {
		Optional<Appointment> appointmentOpt = appointmentRepo.findById(appointmentId);
		if (appointmentOpt.isPresent()) {
			Appointment appointment = appointmentOpt.get();
			appointment.setStatus(status);
			appointmentRepo.save(appointment);
		}
	}

	@Override
	public List<Appointment> getUpcomingAppointments(Long branchId) {

		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		List<Appointment> appointments = appointmentRepo.findByStatusAndBranch("APPROVED", branch);

		LocalDateTime now = LocalDateTime.now();

		return appointments.stream().filter(appointment -> appointment.getStart().isAfter(now))
				.collect(Collectors.toList());
	}

	@Override
	public List<Appointment> getOnProgressAppointments(Long branchId) {

		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		List<Appointment> appointments = appointmentRepo.findByStatusAndBranch("APPROVED", branch);

		LocalDateTime now = LocalDateTime.now();

		return appointments.stream()
				.filter(appointment -> !appointment.getStart().isAfter(now) && !appointment.getEnd().isBefore(now))
				.collect(Collectors.toList());
	}

	@Override
	public List<Appointment> getFinishedAppointments(Long branchId) {

		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		List<Appointment> appointments = appointmentRepo.findByStatusAndBranch("APPROVED", branch);

		LocalDateTime now = LocalDateTime.now();

		return appointments.stream().filter(appointment -> appointment.getEnd().isBefore(now))
				.collect(Collectors.toList());
	}

	@Override
	public List<Appointment> getAllAppointments(Long branchId) {
		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		return appointmentRepo.findByBranch(branch);
	}

	@Override
	public List<Appointment> getCalendarAppointments() {
		List<Appointment> appts = appointmentRepo.findByStatusIn(Arrays.asList("APPROVED", "SCHEDULED"));
		return appts;
	}

	@Override
	public Appointment addAppointment(Appointment appointment) {
		return appointmentRepo.save(appointment);
	}

}
