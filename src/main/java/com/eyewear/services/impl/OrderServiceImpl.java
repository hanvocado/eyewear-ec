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
    private OrderRepository orderRepository;

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
        return orderRepository.save(entity);
    }

    // Thêm 3 method mới
    @Override
    public List<Order> getAllOrdersSortByDate() {
        return orderRepository.findAllByOrderByOrderAtDesc();
    }

    @Override
    public void updateOrderStatus(Long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        order.setStatus(newStatus);
        orderRepository.save(order);
    }

    @Override
    public void bulkUpdateOrderStatus(List<Long> orderIds, String newStatus) {
        List<Order> orders = orderRepository.findAllById(orderIds);
        orders.forEach(order -> order.setStatus(newStatus));
        orderRepository.saveAll(orders);
    }
}