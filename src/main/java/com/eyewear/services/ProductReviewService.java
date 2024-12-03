package com.eyewear.services;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.eyewear.entities.ProductReview;


public interface ProductReviewService {
	
	ProductReview addReview(ProductReview review);

	boolean editReview(int reviewId);
	
	Page<ProductReview> findAll(Pageable pageable,Long productId);

	List<ProductReview> findAll(Long productId);

	<S extends ProductReview> S save(S entity);
	
	List<ProductReview> findAll(Long productId,int rating);
	
	Optional<ProductReview> getReviewByBuyerAndProduct(Long buyerId, Long productId);
	
	Page<ProductReview> findAll(Pageable pageable, Long productId, Integer rating);

	
	long countReviewsByProductId(Long productId);

	double calculateAverageRating(Long productId);



	long countByProductId(Long productId);
	
	

}
