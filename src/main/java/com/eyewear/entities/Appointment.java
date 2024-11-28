package com.eyewear.entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

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
	private int id;

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
	public String getFormattedTimeRange() {
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
	    return start.format(formatter) + " - " + end.format(formatter);
	}
}
