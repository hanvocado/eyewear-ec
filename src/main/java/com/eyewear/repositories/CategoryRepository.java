package com.eyewear.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.eyewear.entities.Category;

public interface CategoryRepository extends JpaRepository<Category, Long>{
	Page<Category> findByNameContaining(String name, Pageable pageable);
	
	Page<Category> findAll(Pageable pageable);

}
