package com.eyewear.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Product;
import com.eyewear.entities.ProductReview;
import com.eyewear.repositories.ProductReviewRepository;
import com.eyewear.services.ProductReviewService;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {

	@Autowired
	ProductReviewRepository reviewRepo;
	


	@Override
	public ProductReview addReview(int productId, int rating, String content) {
		
		return null;
	}

	

	@Override
	public boolean editReview(int reviewId) {
		// TODO Auto-generated method stub
		return false;
	}



	@Override
	public <S extends ProductReview> S save(S entity) {
		// TODO Auto-generated method stub
		return reviewRepo.save(entity);
	}


	@Override
	public Page<ProductReview> findAll(Pageable pageable, Long productId) {
		// TODO Auto-generated method stub
		return reviewRepo.findByProductId(productId, pageable);
	}



	@Override
	public List<ProductReview> findAll(Long productId) {
		// TODO Auto-generated method stub
		return reviewRepo.findByProductId(productId);
	}



	@Override
	public List<ProductReview> findAll(Long productId, int rating) {
		// TODO Auto-generated method stub
		return reviewRepo.findByProductIdAndRating(productId, rating);
	}

	@Override
	public Optional<ProductReview> getReviewByBuyerAndProduct(Long buyerId, Long productId) {
		return reviewRepo.findByBuyerIdAndProductId(buyerId, productId);
	}
	
	
	@Override
    public Page<ProductReview> findAll(Pageable pageable, Long productId, Integer rating) {
        if (rating != null) {
            return reviewRepo.findByProductIdAndRating(productId, rating, pageable);
        } else {
            return reviewRepo.findByProductId(productId, pageable);
        }
    }
	
	@Override
	public long countByProductId(Long productId) {
		return reviewRepo.countByProductId(productId);
	}
}
