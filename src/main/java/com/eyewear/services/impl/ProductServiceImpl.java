package com.eyewear.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Product;
import com.eyewear.entities.ProductColor;
import com.eyewear.entities.ProductSpecification;
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


	@Override
	public Page<Product> findByCategoryId(List<Long> categoryId, Pageable pageable) {
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
		productRepo.updateProduct(product.getId(), product.getName(), product.getPrice(), product.getDescription(), product.getBrand());
	}

	@Override
	public Page<Product> findByNameContaining(String name, Pageable pageable) {
		return productRepo.findByNameContaining(name, pageable);
	}

	@Override
	public Page<Product> findByCriteria(List<String> categoryNames, List<String> brand, Double minPrice, Double maxPrice, Pageable pageable) {
        Specification<Product> spec = ProductSpecification.filterByCriteria(categoryNames, brand, minPrice, maxPrice);
        return productRepo.findAll(spec, pageable);
    }

	@Override
	public Double findMaxPrice() {
		return productRepo.findMaxPrice();
	}

	@Override
	public Double findMinPrice() {
		return productRepo.findMinPrice();
	}

	@Override
	public Product getProductById(long id) {
        return productRepo.findById(id).orElse(null); // Truy vấn sản phẩm từ Repository
    }
	@Override
	public List<Product> findByCategoryIdOrBrand(Long categoryId, String brand, Long productId){
		return productRepo.findByCategoryIdOrBrand(categoryId, brand, productId);
	}
	@Override
	public List<ProductColor> findByProductId(Long id){
		return productRepo.findByProductId(id);
	}
	
}
