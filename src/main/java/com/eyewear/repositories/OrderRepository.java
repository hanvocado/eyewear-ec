package com.eyewear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Order;

@Repository
public interface OrderRepository  extends JpaRepository<Order, Long>{
	
}
