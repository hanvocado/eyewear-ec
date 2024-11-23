package com.eyewear.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Order;
import com.eyewear.repositories.OrderRepository;
import com.eyewear.services.OrderService;

@Service
public class OrderServiceImpl implements OrderService{

	@Autowired
	OrderRepository orderRepo;
	
	@Override
	public <S extends Order> S placeOrder(S entity) {
		// TODO Auto-generated method stub
		return orderRepo.save(entity);
	}

}
