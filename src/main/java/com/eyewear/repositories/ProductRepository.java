package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Product;

@Repository 
public interface ProductRepository extends JpaRepository<Product, Long>{
	// Tìm kiếm theo tên
	List<Product> findByNameContainingIgnoringCase(String name);
	
	// Tìm kiếm theo tên và phân trang
	Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);
	
}
