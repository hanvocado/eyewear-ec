package com.eyewear.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Product;
import com.eyewear.repositories.ProductRepository;
import com.eyewear.services.ProductService;

import jakarta.validation.Valid;

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

	@Override
	public void deleteById(Long productId) {
		productRepo.deleteById(productId);
	}

	@Override
	public void save(@Valid Product product) {
		productRepo.save(product);
	}

	@Override
	public void update(@Valid Product product) {
		productRepo.updateProduct(product.getId(), product.getName(), product.getPrice(), product.getDescription(), product.getBrand());
	}

	@Override
	public long count() {
		return productRepo.count();
	}

	@Override
	public Page<Product> findByNameContaining(String name, Pageable pageable) {
		return productRepo.findByNameContaining(name, pageable);
	}

	@Override
	public Page<Product> findAll(Pageable pageable) {
		return productRepo.findAll(pageable);
	}
	
}
