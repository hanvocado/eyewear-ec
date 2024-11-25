package com.eyewear.services;

import java.util.List;

import com.eyewear.entities.Order;

public interface OrderService {
    List<Order> getOrdersByBuyer(Long buyerId);
    Order getOrderDetail(Long orderId, Long buyerId);
    public void placeOrder(Order order);
    
    public String cancelOrder(Long orderId);
}