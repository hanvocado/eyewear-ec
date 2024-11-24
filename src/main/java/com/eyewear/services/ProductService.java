package com.eyewear.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.eyewear.entities.Product;

import jakarta.validation.Valid;

public interface ProductService {
	List<Product> findAll();
	
	List<Product> findByName(String name);
	
	Product findById(Long id);

	void deleteById(Long productId);

	void save(@Valid Product product);

	void update(@Valid Product product);

	long count();

	Page<Product> findByNameContaining(String name, Pageable pageable);

	Page<Product> findAll(Pageable pageable);
	
}
