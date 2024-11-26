package com.eyewear.entities;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "appointments")
public class Appointment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private LocalDateTime from;
	private LocalDateTime to;
	private LocalDateTime createdAt;
	private String status;
	private String note;

	@ManyToOne
	@JoinColumn(name = "buyer_id", nullable = false)
	private Buyer buyer;
}
