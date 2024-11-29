package com.eyewear.entities;

import java.util.List;
import java.util.stream.Collectors;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "product_type", discriminatorType = DiscriminatorType.STRING)
@Table(name = "products", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Long id;
	
	@Column(length=100, nullable = false)
	private String name;
	
	@Column(nullable = false)
	private double price;
	
	private String description;
	
	private String brand;
		
	private String image; // đường dẫn đến Cloudinary
	
	@Column(nullable=true)
	private Float height;
	
	@Column(nullable=true)
	private Float width;
	
	//không cần lưu trữ vào cơ sở dữ liệu
	@Transient
    private String imageUrl; // URL to be generated

    @ManyToOne
    @JoinColumn(name = "category_id")
    @JsonIgnore // Thêm để tránh vòng lặp tuần hoàn khi gọi toString hoặc chuyển đổi JSON
    private Category category;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonIgnore // Thêm để tránh vòng lặp tuần hoàn khi gọi toString hoặc chuyển đổi JSON
    private List<BranchProduct> branches;

    @Transient
    public List<BranchProduct> getAvailBranches() {
        return branches.stream()
                .filter(branchProduct -> branchProduct.getQuantity() > 0)
                .collect(Collectors.toList());
    }
    @Override
    public String toString() {
        return "Product{id=" + id + ", name='" + name + "', price=" + price + "}";
    }
}
