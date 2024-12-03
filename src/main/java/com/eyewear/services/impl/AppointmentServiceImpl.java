package com.eyewear.services.impl;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.management.RuntimeErrorException;

import org.springframework.beans.BeanUtils;
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

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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

		List<Appointment> finishedAppointments = appointments.stream()
				.filter(appointment -> appointment.getEnd().isBefore(now)).collect(Collectors.toList());

		finishedAppointments.forEach(appointment -> appointment.setStatus("FINISHED"));

		appointmentRepo.saveAll(finishedAppointments);

		return finishedAppointments;
	}

	@Override
	public List<Appointment> getAllAppointments(Long branchId) {
		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		return appointmentRepo.findByBranch(branch);
	}

	@Override
	public List<Appointment> getAppointmentsByStatus(List<String> statuses, Long branchId) {
		Branch branch = branchRepository.findById(branchId)
				.orElseThrow(() -> new RuntimeException("Không tìm thấy cửa hàng chi nhánh"));
		List<Appointment> appts = appointmentRepo.findByStatusInAndBranch(statuses, branch);
//        if (log.isInfoEnabled()) {
//            log.info("Fetched {} appointments with statuses {} for branchId {}: {}", 
//                    appts.size(), statuses, branchId, appts);
//        }
		return appts;
	}

	@Override
	public Appointment save(Appointment appointment) {
		if (appointment.getId() == null || !appointmentRepo.existsById(appointment.getId())) {
			appointment.setStatus("SCHEDULED");
			appointment.setCreatedAt(LocalDateTime.now());
			return appointmentRepo.save(appointment);
		}
		Appointment apt = appointmentRepo.findById(appointment.getId())
				.orElseThrow(() -> new RuntimeException("Không tìm thấy lịch hẹn"));
		apt.setId(appointment.getId());
		apt.setStart(appointment.getStart());
		apt.setEnd(appointment.getEnd());
		apt.setMessage(appointment.getMessage());
		return appointmentRepo.save(apt);
	}

	@Override
	public Appointment getAppointment(Long id) {
		return appointmentRepo.findById(id).orElse(null);
	}

	@Override
	public void deleteAppointment(Long id) {
		appointmentRepo.deleteById(id);
	}

}
