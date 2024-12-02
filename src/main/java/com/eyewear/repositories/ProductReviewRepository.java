package com.eyewear.repositories;


import java.util.List;
import java.util.Optional;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.ProductReview;

@Repository
public interface ProductReviewRepository extends JpaRepository<ProductReview, Integer> {
	Optional<ProductReview> findByBuyerIdAndProductId(Long buyerId, Long productId);
	Page<ProductReview> findByProductId(Long productId, Pageable pageable);

    List<ProductReview> findByProductId(Long productId);

    List<ProductReview> findByProductIdAndRating(Long productId, int rating);
    Page<ProductReview> findByProductIdAndRating(Long productId, Integer rating, Pageable pageable);
    
}
