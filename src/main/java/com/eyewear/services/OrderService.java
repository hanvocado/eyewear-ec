package com.eyewear.services;

import com.eyewear.entities.Order;
import java.util.List;

public interface OrderService {
    List<Order> getOrdersByBuyer(Long buyerId);
    Order getOrderDetail(Long orderId, Long buyerId);
}