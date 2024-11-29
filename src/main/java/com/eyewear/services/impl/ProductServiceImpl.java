package com.eyewear.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
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
	
	// Tìm kiếm sản phẩm có phân trang
	@Override
	public Page<Product> searchProduct(String name, Pageable pageable){
		return productRepo.findByNameContainingIgnoreCase(name, pageable);
	}

	@Override
	public long count() {
		return productRepo.count();
	}
	
	@Override
	public List<Product> findAll(Sort sort) {
		return productRepo.findAll(sort);
	}

	@Override
	public Page<Product> findAll(Pageable pageable) {
		return productRepo.findAll(pageable);
	}
	//


	@Override
	public Page<Product> findByCategoryNameInAndPriceBetween(List<Long> categoryId, Double minPrice,
			Double maxPrice, Pageable pageable) {
		return productRepo.findByCategoryNameInAndPriceBetween(categoryId, minPrice, maxPrice, pageable);
	}

	@Override
	public Page<Product> findByCategoryId(List<Long> categoryId, Pageable pageable) {
		// TODO Auto-generated method stub
		return productRepo.findByCategoryIdIn(categoryId, pageable);
	}


	
	@Override
	public List<Product> getProductsById(List<Long> listId) {
		return productRepo.findAllByIdIn(listId);
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
		productRepo.updateProduct(product.getId(), product.getName(), product.getPrice(), product.getDescription(), product.getBrand(), product.getCategory());
	}

	@Override
	public Page<Product> findByNameContaining(String name, Pageable pageable) {
		return productRepo.findByNameContaining(name, pageable);
	}

	@Override
	public List<Product> findListById(Iterable<Long> id) {
		// TODO Auto-generated method stub
		return productRepo.findAllById(id);
	}


}
