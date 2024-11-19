package com.eyewear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.eyewear.entities.ProductReview;

public interface ProductReviewRepository extends JpaRepository<ProductReview, Long> {

}
