package com.eyewear.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.repositories.AppointmentRepository;
import com.eyewear.services.AppointmentService;

@Service
public class AppointmentServiceImpl implements AppointmentService{

	@Autowired
	private AppointmentRepository appointmentRepo;
	
	
}
