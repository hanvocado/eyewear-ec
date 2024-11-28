package com.eyewear.services;

import java.util.Optional;

import com.eyewear.entities.Buyer;

public interface BuyerService {

	Optional<Buyer> findById(Long id);

}