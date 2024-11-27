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

    @Column(name = "from_date")
	private LocalDateTime from;
    
    @Column(name = "to_date")
	private LocalDateTime to;
    
	private LocalDateTime createdAt;
	private String status;
	
	@Column(length = 500)
	private String message;

	@Column(length = 500)
	private String services;

	@Column(length = 500)
	private String images;
	
	@ManyToOne
	@JoinColumn(name = "buyer_id", nullable = false)
	private Buyer buyer;

	@ManyToOne
	@JoinColumn(name = "branch_id", nullable = false)
	private Branch branch;
}
