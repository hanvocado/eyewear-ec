package com.eyewear.services;

import java.time.LocalDateTime;
import java.util.List;

import com.eyewear.entities.Appointment;
import com.eyewear.entities.Branch;

public interface AppointmentService {

	boolean bookAppointment(LocalDateTime startDateTime, LocalDateTime endDateTime, String message, List<String> services, Long buyerId, Long branchId);

	List<String> getFormattedAppointmentsScheduled();

	List<Appointment> getAppointmentsByStatusAndBranch(String status, Long branchId);

	void updateStatus(Long appointmentId, String status);

	List<Appointment> getAllAppointments(Long branchId);

	List<Appointment> getFinishedAppointments(Long branchId);

	List<Appointment> getOnProgressAppointments(Long branchId);

	List<Appointment> getUpcomingAppointments(Long branchId);

	Appointment addAppointment(Appointment appointment);

	List<Appointment> getCalendarAppointments();

}
