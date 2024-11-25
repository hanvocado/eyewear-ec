package com.eyewear.controllers.buyer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eyewear.entities.Order;
import com.eyewear.services.OrderService;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/buyer/orders")  // Thêm prefix /buyer để phân biệt với admin
public class BuyerOrderController {
    
    @Autowired
    private OrderService orderService;
    
    // Hiển thị danh sách/lịch sử đơn hàng (gộp 2 phương thức getPurchaseHistory và getMyOrders)
    @GetMapping({"/my-orders", "/history"})  // Hỗ trợ cả 2 URL pattern
    public String getOrderHistory(Model model, Principal principal) {
        Long buyerId = getCurrentBuyerId(principal);
        List<Order> orders = orderService.getOrdersByBuyer(buyerId);
        model.addAttribute("orders", orders);
        return "buyer/order-history";  // Thống nhất tên view
    }
    
    // Xem chi tiết đơn hàng
    @GetMapping("/{orderId}")
    public String getOrderDetail(@PathVariable Long orderId, Model model, Principal principal) {
        Long buyerId = getCurrentBuyerId(principal);
        Order order = orderService.getOrderDetail(orderId, buyerId);
        model.addAttribute("order", order);
        return "buyer/order-detail";
    }

    private Long getCurrentBuyerId(Principal principal) {
        // TODO: Implement logic to get current buyer id from Principal
        return 1L; // Temporary return
    }
}