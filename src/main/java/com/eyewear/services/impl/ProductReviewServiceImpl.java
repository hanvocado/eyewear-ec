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
	public void delete(ProductReview entity) {
		// TODO Auto-generated method stub
		
	}

	
	
	@Override
	public Optional<ProductReview> findById(Long id) {
		// TODO Auto-generated method stub
		return Optional.empty();
	}

	@Override
	public Page<ProductReview> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ProductReview> findAll() {
		// TODO Auto-generated method stub
		return null;
	}



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
	public Optional<ProductReview> getReviewByBuyerAndProduct(Long buyerId, Long productId) {
		return reviewRepo.findByBuyerIdAndProductId(buyerId, productId);
	}
	
}
