package com.eyewear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.eyewear.entities.Order;


public interface OrderRepository  extends JpaRepository<Order, Long>{
	
}
