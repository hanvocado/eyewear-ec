package com.eyewear.services;

import java.util.List;

import com.eyewear.entities.Product;

public interface ProductService {
	List<Product> findAll();
	
	List<Product> findByName(String name);
	
	Product findById(Long id);

	List<Product> getProductsById(List<Long> listId);
}
