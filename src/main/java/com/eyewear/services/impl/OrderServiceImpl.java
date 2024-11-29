package com.eyewear.services.impl;

import com.eyewear.entities.Order;
import com.eyewear.entities.OrderDetail;
import com.eyewear.repositories.OrderDetailRepository;
import com.eyewear.repositories.OrderRepository;
import com.eyewear.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    OrderDetailRepository orderDetailRepository;
    @Override
    public List<Order> getOrdersByBuyer(Long buyerId) {
        return orderRepository.findAllByBuyerId(buyerId);
    }
    
    public List<Order> getOrdersByBuyerAndStatus(Long buyerId, List<String> statuses) {
        return orderRepository.findByBuyerIdAndStatusIn(buyerId, statuses);
    }
    
    public List<Order> getHistoryOrdersByBuyer(Long buyerId) {
    	return orderRepository.findByBuyerIdAndStatusIn(
                buyerId, 
                Arrays.asList("COMPLETED", "CANCELED")
            );
    }

    @Override
    public Order getOrderDetail(Long orderId, Long buyerId) {
        return orderRepository.findOrderDetailByIdAndBuyerId(orderId, buyerId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }
    @Override
    public void placeOrder(Order order) {
        // Lưu đơn hàng trước
        orderRepository.save(order);

        // Lưu các chi tiết đơn hàng
        for (OrderDetail detail : order.getItems()) {
            detail.setOrder(order); // Đảm bảo mỗi detail gắn với order
            orderDetailRepository.save(detail);
        }
    }

	@Override
	public String cancelOrder(Long orderId) {
		Optional<Order> order = orderRepository.findById(orderId);
		if(order.isPresent()) {
			Order editOrder =order.get();
			if(editOrder.getStatus().equalsIgnoreCase("Done")) {
				return "Đơn hàng đã giao";
			}else if(editOrder.getStatus().equalsIgnoreCase("Pending")){
				editOrder.setStatus("Canceled");
				orderRepository.save(editOrder);
				return "Huỷ đơn thành công";
			}
			
		}
		return "loi";
	}

	@Override
	public List<Order> getAllOrdersSortByDate() {
	    return orderRepository.findAllByOrderByOrderAtDesc();
	}

	@Override
	public void updateOrderStatus(Long orderId, String newStatus) {
	    Optional<Order> orderOpt = orderRepository.findById(orderId);
	    if (orderOpt.isPresent()) {
	        Order order = orderOpt.get();
	        // Kiểm tra nếu status mới khác status hiện tại
	        if (!newStatus.equals(order.getStatus())) {
	            order.setStatus(newStatus); // Chỉ set status mới, không nối chuỗi
	            orderRepository.save(order);
	        }
	    }
	}

	@Override
	@Transactional
	public void bulkUpdateOrderStatus(List<Long> orderIds, String newStatus) {
	    for (Long orderId : orderIds) {
	        Optional<Order> orderOpt = orderRepository.findById(orderId);
	        if (orderOpt.isPresent()) {
	            Order order = orderOpt.get();
	            // Kiểm tra nếu status mới khác status hiện tại
	            if (!newStatus.equals(order.getStatus())) {
	                order.setStatus(newStatus); // Chỉ set status mới, không nối chuỗi
	                orderRepository.save(order);
	            }
	        }
	    }
	}

}