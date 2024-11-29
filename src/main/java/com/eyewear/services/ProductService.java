package com.eyewear.services;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import com.eyewear.entities.Product;

import jakarta.validation.Valid;

public interface ProductService {
	List<Product> findAll();
	
	List<Product> findByName(String name);
	
	Product findById(Long id);
	
	// Tìm kiếm sản phẩm có phân trang
	Page<Product> findAll(Pageable pageable);
	
	List<Product> findAll(Sort sort);

	long count();

	Page<Product> searchProduct(String name, Pageable pageable);
	// Lọc sản phẩm
	
	Page<Product> findByCategoryNameInAndPriceBetween(List<Long> categoryId, Double minPrice, Double maxPrice, Pageable pageable);

	Page<Product> findByCategoryId(List<Long> categoryId, Pageable pageable);

	List<Product> getProductsById(List<Long> listId);
	
	void deleteById(Long productId);

	void save(@Valid Product product);

	void update(@Valid Product product);

	Page<Product> findByNameContaining(String name, Pageable pageable);

	List<Product> findListById(Iterable<Long> id);
}
