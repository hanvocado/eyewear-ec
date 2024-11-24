package com.eyewear.services;

import java.util.List;

import com.eyewear.entities.Order;

public interface OrderService {
    List<Order> getOrdersByBuyer(Long buyerId);
    Order getOrderDetail(Long orderId, Long buyerId);
    
    List<Order> getAllOrdersSortByDate();
    void updateOrderStatus(Long orderId, String newStatus);
    void bulkUpdateOrderStatus(List<Long> orderIds, String newStatus);
    
    <S extends Order> S placeOrder(S entity);
}