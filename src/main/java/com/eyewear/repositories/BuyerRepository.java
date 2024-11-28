package com.eyewear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Buyer;

@Repository
public interface BuyerRepository extends JpaRepository<Buyer, Long>{
	
}