package com.eyewear.controllers.buyer;

import com.eyewear.entities.Order;
import com.eyewear.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;  // Bỏ final đi

    @GetMapping("/my-orders")
    public String getMyOrders(Model model, Principal principal) {
        Long buyerId = getCurrentUserId(principal);
        List<Order> orders = orderService.getOrdersByBuyer(buyerId);
        model.addAttribute("orders", orders);
        return "buyer/order-list";
    }

    @GetMapping("/{orderId}")
    public String getOrderDetail(@PathVariable Long orderId,
                               Model model,
                               Principal principal) {
        Long userId = getCurrentUserId(principal);
        Order order = orderService.getOrderDetail(orderId, userId);
        model.addAttribute("order", order);
        return "buyer/order-detail";
    }

    private Long getCurrentUserId(Principal principal) {
        // Implement logic to get current user id from Principal
        return 1L; // Temporary return for example
    }
}