package com.eyewear.entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import com.eyewear.utils.ServiceType;
import com.eyewear.utils.StringListConverter;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "appointments")
public class Appointment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	private LocalDateTime start;

	private LocalDateTime end;

	private LocalDateTime createdAt;
	private String status;

	@Column(length = 500)
	private String message;

	@Convert(converter = StringListConverter.class)
	@Column(length = 500)
	private List<String> services;

	@ManyToOne
	@JoinColumn(name = "buyer_id", nullable = false)
	private Buyer buyer;

	@ManyToOne
	@JoinColumn(name = "branch_id", nullable = false)
	private Branch branch;

	@Transient
	public String getFormattedAppointment() {
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

		String formattedDate = start.format(dateFormatter);
		String startTime = start.format(timeFormatter);
		String endTime = end.format(timeFormatter);

		return formattedDate + " " + startTime + " - " + endTime;
	}

	@Transient
	public String getFormattedCreatedAt() {
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
		DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

		String date = createdAt.format(dateFormatter);
		String time = createdAt.format(timeFormatter);

		return date + " " + time;
	}

	public String getServicesDisplay() {
		if (services == null || services.isEmpty()) {
			return "";
		}

		return services.stream().map(service -> {
			ServiceType serviceType = ServiceType.fromString(service);
			return serviceType != null ? serviceType.getDisplayName() : service;
		}).collect(Collectors.joining(", "));
	}
}