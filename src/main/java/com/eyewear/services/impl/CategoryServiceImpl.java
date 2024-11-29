package com.eyewear.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Category;
import com.eyewear.repositories.CategoryRepository;
import com.eyewear.services.CategoryService;

import jakarta.validation.Valid;

@Service
public class CategoryServiceImpl implements CategoryService{
	@Autowired
	private CategoryRepository categoryRepo;
	
	@Override
	public List<Category> findAll() {
		
		return categoryRepo.findAll();
	}

	@Override
	public void save(@Valid Category category) {
		categoryRepo.save(category);
		
	}

	@Override
	public Category findById(Long id) {
		return categoryRepo.findById(id).orElse(null);	
	}

	@Override
	public void update(@Valid Category category) {
		categoryRepo.save(category);
	}

	@Override
	public void deleteById(Long id) {
		categoryRepo.deleteById(id);
	}

	@Override
	public long count() {
		return categoryRepo.count();
	}

	@Override
	public Page<Category> findByNameContaining(String name, Pageable pageable) {
		// TODO Auto-generated method stub
		return categoryRepo.findByNameContaining(name,pageable);
	}

	@Override
	public Page<Category> findAllPage(Pageable pageable) {
		// TODO Auto-generated method stub
		return categoryRepo.findAll(pageable);
	}
	
}
