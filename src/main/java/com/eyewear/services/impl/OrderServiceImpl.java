package com.eyewear.services.impl;

import com.eyewear.entities.Order;
import com.eyewear.entities.OrderDetail;
import com.eyewear.repositories.OrderDetailRepository;
import com.eyewear.repositories.OrderRepository;
import com.eyewear.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;  // bỏ final đi

    @Autowired
    OrderDetailRepository orderDetailRepository;
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
			if(editOrder.getStatus()=="done") {
				return "Đơn hàng đã giao";
			}
			editOrder.setStatus("done");
			orderRepository.save(editOrder);
			return "Huỷ đơn thành công";
		}
		return "loi";
	}

}