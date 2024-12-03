package com.eyewear.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

import com.eyewear.entities.BranchProduct;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class EventModel implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long id;
	private LocalDateTime start;
	private LocalDateTime end;
	private String message;
}
