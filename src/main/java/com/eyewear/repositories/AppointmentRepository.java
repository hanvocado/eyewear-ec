package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Appointment;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
	 List<Appointment> findByBuyerId(Long buyerId);
}
