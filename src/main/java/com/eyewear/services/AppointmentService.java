package com.eyewear.services;

import java.time.LocalDateTime;
import java.util.List;

import com.eyewear.entities.Appointment;
import com.eyewear.entities.Branch;

public interface AppointmentService {

	boolean bookAppointment(LocalDateTime startDateTime, LocalDateTime endDateTime, String message, List<String> services, Long buyerId, Long branchId);

	List<String> getFormattedAppointmentsScheduled();

}
