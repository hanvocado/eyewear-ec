package com.eyewear.services.impl;

import java.time.LocalDateTime;
import java.util.List;

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
			Buyer buyer = buyerRepository.findById(buyerId)
			        .orElseThrow(() -> new RuntimeException("Buyer not found"));
			
			Branch branch = branchRepository.findById(branchId)
			        .orElseThrow(() -> new RuntimeException("Branch not found"));
			
			String status = AppointmentStatus.PENDING.name();
			
			Appointment appointment = Appointment.builder().start(startDateTime).end(endDateTime)
					.createdAt(LocalDateTime.now()).message(message).status(status).services(services).buyer(buyer).branch(branch).build();

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
	
	

}
