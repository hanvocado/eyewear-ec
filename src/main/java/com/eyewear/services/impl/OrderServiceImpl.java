package com.eyewear.services.impl;

import com.eyewear.entities.Order;
import com.eyewear.repositories.OrderRepository;
import com.eyewear.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;  // bỏ final đi

    @Override
    public List<Order> getOrdersByBuyer(Long buyerId) {
        return orderRepository.findAllByBuyerId(buyerId);
    }

    @Override
    public Order getOrderDetail(Long orderId, Long buyerId) {
        return orderRepository.findOrderDetailByIdAndBuyerId(orderId, buyerId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }

    @Override
	public <S extends Order> S placeOrder(S entity) {
		// TODO Auto-generated method stub
		return orderRepository.save(entity);
	}
}