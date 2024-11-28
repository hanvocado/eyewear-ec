package com.eyewear.services.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Buyer;
import com.eyewear.repositories.BuyerRepository;
import com.eyewear.services.BuyerService;

@Service
public class BuyerServiceImpl implements BuyerService{
	@Autowired
	BuyerRepository buyerRepository;

	@Override
	public Optional<Buyer> findById(Long id) {
		return buyerRepository.findById(id);
	} 
	
}