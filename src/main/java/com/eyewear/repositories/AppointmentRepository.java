package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Appointment;
import com.eyewear.entities.Branch;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
	List<Appointment> findByBuyerId(Long buyerId);

	@Query("SELECT CONCAT(FORMAT(a.start, '%d-%m-%Y %H:%i'), ' - ', FORMAT(a.end, '%H:%i')) AS formattedTime "
			+ "FROM Appointment a WHERE a.status = :status " + "ORDER BY a.start ASC")
	List<String> findFormattedAppointmentsByStatus(@Param("status") String status);

	List<Appointment> findByStatusAndBranch(String status, Branch branch);
	
	List<Appointment> findByBranch(Branch branch);
	
	List<Appointment> findByStatusInAndBranch(List<String> statuses, Branch branch);
}
