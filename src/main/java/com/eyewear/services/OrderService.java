package com.eyewear.services;

import java.util.List;

import com.eyewear.entities.Order;

public interface OrderService {
    List<Order> getOrdersByBuyer(Long buyerId);
    Order getOrderDetail(Long orderId, Long buyerId);
    <S extends Order> S placeOrder(S entity);
}