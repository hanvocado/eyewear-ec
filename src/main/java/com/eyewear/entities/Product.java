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
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)  // Sử dụng Single Table Inheritance
@DiscriminatorColumn(name = "product_type", discriminatorType = DiscriminatorType.STRING)  // Cột phân biệt loại sản phẩm
@Table(name = "products", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(length=100, nullable = false)
	private String name;
	
	@Column(nullable = false)
	private double price;
	
	private String description;
	
	private String brand;
	
	private String image; // đường dẫn đến Cloudinary
	
	//không cần lưu trữ vào cơ sở dữ liệu
	@Transient
    private String imageUrl; // URL to be generated

	@ManyToOne
	@JoinColumn(name = "category_id")  //khóa ngoại "category_id"
    private Category category;
	
	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BranchProduct> branches;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	

	
	@Transient
	public List<BranchProduct> getAvailBranches() {
		return branches.stream()
                .filter(branchProduct -> branchProduct.getQuantity() > 0)
                .collect(Collectors.toList());
	}
	
}

