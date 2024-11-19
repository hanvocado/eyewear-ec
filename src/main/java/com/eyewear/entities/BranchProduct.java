package com.eyewear.entities;

import jakarta.persistence.*;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "branch-product")
public class BranchProduct {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
	private Product product;
	
	@ManyToOne
    @JoinColumn(name = "branch_id", nullable = false)
	private Branch branch;
	
	@Column(nullable = false)
	private int quantity = 0;
}
