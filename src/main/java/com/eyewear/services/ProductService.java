package com.eyewear.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.eyewear.entities.Product;

public interface ProductService {
	List<Product> findAll();
	
	List<Product> findByName(String name);
	
	Product findById(Long id);
	
	// Tìm kiếm sản phẩm có phân trang
	Page<Product> findAll(Pageable pageable);

	long count();

	Page<Product> searchProduct(String name, Pageable pageable);
	//
}
