package com.eyewear.controllers.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.Order;
import com.eyewear.services.OrderService;

import java.util.List;

@Controller
@RequestMapping("/manager/orders")
public class OrderManagementController {
    
    @Autowired
    private OrderService orderService;
    
    // Hiển thị danh sách đơn hàng
    @GetMapping("")
    public String getOrderList(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model) {
        Page<Order> pageResult = orderService.getAllOrdersSortByDatePaginated(PageRequest.of(page, size));
        model.addAttribute("orders", pageResult.getContent());
        model.addAttribute("pageNumber", pageResult.getNumber());
        model.addAttribute("totalPages", pageResult.getTotalPages());
        model.addAttribute("totalElements", pageResult.getTotalElements());
        model.addAttribute("numberOfElements", pageResult.getNumberOfElements());
        return "manager/order-list";
    }
    
    // Cập nhật trạng thái một đơn hàng
    @PostMapping("/update-status/{orderId}")
    public String updateOrderStatus(
            @PathVariable Long orderId,
            @RequestParam String newStatus,
            RedirectAttributes redirectAttrs) {
        try {
            orderService.updateOrderStatus(orderId, newStatus);
            redirectAttrs.addFlashAttribute("successMessage", 
                "Cập nhật trạng thái đơn hàng thành công");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", 
                "Lỗi khi cập nhật trạng thái đơn hàng");
        }
        return "redirect:/manager/orders";
    }
    
    // Cập nhật trạng thái nhiều đơn hàng
    @PostMapping("/bulk-update")
    public String bulkUpdateStatus(
            @RequestParam("orderIds") List<Long> orderIds,
            @RequestParam("bulkStatus") String newStatus,  // Đổi tên parameter
            RedirectAttributes redirectAttrs) {
        try {
            orderService.bulkUpdateOrderStatus(orderIds, newStatus);
            redirectAttrs.addFlashAttribute("successMessage", 
                "Cập nhật trạng thái các đơn hàng thành công");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMessage", 
                "Lỗi khi cập nhật trạng thái đơn hàng");
        }
        return "redirect:/manager/orders";
    }
}