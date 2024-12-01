package com.eyewear.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import com.eyewear.entities.Order;

public interface OrderService {
    List<Order> getOrdersByBuyer(Long buyerId);
    Order getOrderDetail(Long orderId, Long buyerId);
    List<Order> getHistoryOrdersByBuyer(Long buyerId);
    Page<Order> findAll(Specification<Order> spec, Pageable pageable);
    Page<Order> getAllOrdersSortByDatePaginated(Pageable pageable);
    
    List<Order> getAllOrdersSortByDate();
    void updateOrderStatus(Long orderId, String newStatus);
    void bulkUpdateOrderStatus(List<Long> orderIds, String newStatus);
    
    String cancelOrder(Long orderId);
    void placeOrder(Order order);
}