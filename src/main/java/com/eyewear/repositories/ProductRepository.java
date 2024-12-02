package com.eyewear.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.eyewear.entities.Category;
import com.eyewear.entities.Product;
import com.eyewear.entities.ProductColor;

import jakarta.validation.Valid;

@Repository 
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product>{
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
    
    // Sản phẩm tương tự theo danh mục hay theo thương hiệu
    @Query("SELECT p FROM Product p WHERE (p.category.id = :categoryId OR p.brand = :brand) AND p.id <> :productId")
    List<Product> findByCategoryIdOrBrand(@Param("categoryId") Long categoryId, 
                                          @Param("brand") String brand, 
                                          @Param("productId") Long productId);
    
    @Query("SELECT pc FROM ProductColor pc WHERE pc.product.id = :productId")
    List<ProductColor> findByProductId(@Param("productId") Long productId);
    
    List<Product> findByCategoryId(Long id);
}
