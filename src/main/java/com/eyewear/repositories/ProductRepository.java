package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.eyewear.entities.Product;

import jakarta.validation.Valid;

@Repository 
public interface ProductRepository extends JpaRepository<Product, Long>{
	// Tìm kiếm theo tên
	List<Product> findByNameContainingIgnoringCase(String name);
	
	// Tìm kiếm theo tên và phân trang
	Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);

	Page<Product> findAll(Pageable pageable);
	
	// Lọc sản phẩm, có phân trang
	Page<Product> findByCategoryIdIn(List<Long> categoryIds, Pageable pageable);
	// Lọc theo tên danh mục 
	Page<Product> findByCategoryNameIn(List<String> categoryName, Pageable pageable);
	// Lọc theo giá 
	Page<Product> findByCategoryNameInAndPriceBetween(List<Long> categoryId, Double minPrice, Double maxPrice, Pageable pageable);
	
	List<Product> findAllByIdIn(List<Long> ids);
	
	@Modifying
    @Transactional
    @Query("UPDATE Product p SET p.name = :name, p.price = :price, p.description = :description, p.brand = :brand WHERE p.id = :id")
    int updateProduct(@Param("id") Long id,
                      @Param("name") String name,
                      @Param("price") double price,
                      @Param("description") String description,
                      @Param("brand") String brand);

	Page<Product> findByNameContaining(String name, Pageable pageable);
}
