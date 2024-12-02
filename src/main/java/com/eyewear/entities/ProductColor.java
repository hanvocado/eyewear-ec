package com.eyewear.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
@Entity
public class ProductColor {
	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(name = "id", insertable = false, updatable = false) 
	    private Long id;

	    private String color;

	    private String imageUrl;  // URL cho hình ảnh của màu sắc

	    @ManyToOne
	    @JoinColumn(name = "product_id")
	    private Product product;
}