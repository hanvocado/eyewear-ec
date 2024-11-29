package com.eyewear.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.eyewear.entities.Category;

import jakarta.validation.Valid;

public interface CategoryService {

	List<Category> findAll();

	void save(@Valid Category category);

	Category findById(Long id);

	void update(@Valid Category category);

	void deleteById(Long id);

	long count();

	Page<Category> findByNameContaining(String name, Pageable pageable);
	
	Page<Category> findAllPage(Pageable pageable);
	

}
