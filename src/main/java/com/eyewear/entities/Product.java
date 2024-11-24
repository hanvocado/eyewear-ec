package com.eyewear.entities;

import java.util.List;
import java.util.stream.Collectors;

import jakarta.persistence.*;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "products", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "product_id")
	private Long id;
	
	@Column(length=100, nullable = false)
	private String name;
	
	@Column(nullable = false)
	private double price;
	
	private String description;
	
	private String brand;
	
	private String image;
	
	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BranchProduct> branches;


	

	
	@Transient
	public List<BranchProduct> getAvailBranches() {
		return branches.stream()
                .filter(branchProduct -> branchProduct.getQuantity() > 0)
                .collect(Collectors.toList());
	}
	
}

