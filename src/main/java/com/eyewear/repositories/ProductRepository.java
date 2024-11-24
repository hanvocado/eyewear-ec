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
	List<Product> findByNameContainingIgnoringCase(String name);

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
