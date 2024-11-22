package com.eyewear.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Product;
import com.eyewear.repositories.ProductRepository;
import com.eyewear.services.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductRepository productRepo;
	
	@Override
	public List<Product> findAll() {
		return productRepo.findAll();
	}

	@Override
	public List<Product> findByName(String name) {
		return productRepo.findByNameContainingIgnoringCase(name);
	}

	@Override
	public Product findById(Long id) {
		return productRepo.findById(id).orElse(null);
	}

}
