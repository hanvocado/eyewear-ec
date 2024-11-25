package com.eyewear.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.ProductReview;

@Repository
public interface ProductReviewRepository extends JpaRepository<ProductReview, Integer> {
	Optional<ProductReview> findByBuyerIdAndProductId(Long buyerId, Long productId);
	
}
