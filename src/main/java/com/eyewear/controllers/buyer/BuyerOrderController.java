package com.eyewear.controllers.buyer;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest; 
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.*;
import com.eyewear.services.*;

import jakarta.servlet.http.HttpSession;

import java.security.Principal;

@Controller
@RequestMapping("/buyer/orders")  // Thêm prefix /buyer để phân biệt với admin
public class BuyerOrderController {
    
    @Autowired
    private OrderService orderService;
    @Autowired
	ProductService productService;
    @Autowired
    CartService cartService;
    @Autowired
    ProductReviewService reviewService;
    
 // Xem đơn hàng đang xử lý (chờ xác nhận, đã xác nhận, đang giao, đã giao)
    @GetMapping("/my-orders")
    public String getMyOrders(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "5") int size,
        @RequestParam(required = false) String sortBy,
        @RequestParam(defaultValue = "desc") String sortDir,
        @RequestParam(required = false) String status,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
        Model model, 
        HttpSession session
    ) {
        Long buyerId = getCurrentBuyerId(session);
        
        Sort sort = Sort.by(sortDir.equalsIgnoreCase("asc") ? Sort.Direction.ASC : Sort.Direction.DESC, 
                           sortBy != null ? sortBy : "orderAt");
        Pageable pageable = PageRequest.of(page, size, sort);
        
        Specification<Order> spec = Specification.where(byBuyerId(buyerId));
        
        if (status != null && !status.isEmpty()) {
            spec = spec.and(byStatus(status));
        }
        if (fromDate != null) {
            spec = spec.and(byOrderDateGreaterThanOrEqual(fromDate));
        }
        if (toDate != null) {
            spec = spec.and(byOrderDateLessThanOrEqual(toDate));
        }
        
        Page<Order> orders = orderService.findAll(spec, pageable);
        model.addAttribute("orders", orders);
        
        return "buyer/order-track";
    }

    // Thêm Specification methods
    private Specification<Order> byBuyerId(Long buyerId) {
        return (root, query, cb) -> 
            cb.equal(root.get("buyer").get("id"), buyerId);
    }

    private Specification<Order> byStatus(String status) {
        return (root, query, cb) -> 
            cb.equal(cb.lower(root.get("status")), status.toLowerCase());
    }

    private Specification<Order> byOrderDateGreaterThanOrEqual(LocalDate date) {
        return (root, query, cb) -> 
            cb.greaterThanOrEqualTo(root.get("orderAt").as(LocalDate.class), date);
    }

    private Specification<Order> byOrderDateLessThanOrEqual(LocalDate date) {
        return (root, query, cb) -> 
            cb.lessThanOrEqualTo(root.get("orderAt").as(LocalDate.class), date);
    }

    // Xem lịch sử đơn hàng (đã giao)
    @GetMapping("/history") 
    public String getOrderHistory(
        @RequestParam(defaultValue = "0") int page,
        @RequestParam(defaultValue = "5") int size,
        Model model, 
        HttpSession session
    ) {
        Long buyerId = getCurrentBuyerId(session);
        Pageable pageable = PageRequest.of(page, size, Sort.by("orderAt").descending());
        Page<Order> orderPage = orderService.getHistoryOrdersByBuyer(buyerId, pageable);
        
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        
        return "buyer/order-history";
    }
    
    // Xem chi tiết đơn hàng
    @GetMapping("/{orderId}")
    public String getOrderDetail(@PathVariable Long orderId, Model model, HttpSession session) {
        Long buyerId = getCurrentBuyerId(session);
        Order order = orderService.getOrderDetail(orderId, buyerId);
        List<Long> ProductReviewed = new ArrayList<>();
        for(OrderDetail detail: order.getItems()) {
        	Optional<ProductReview> review = reviewService.getReviewByBuyerAndProduct(buyerId, detail.getProduct().getId());
            
            if (review.isPresent()) {
            	ProductReviewed.add(detail.getProduct().getId());
            }
        }
        model.addAttribute("proreviewed",ProductReviewed);
        model.addAttribute("order", order);
        return "buyer/order-detail";
    }

    private Long getCurrentBuyerId(HttpSession session) {
    	   return (Long) session.getAttribute("userId");
    	}
    
    
    //trantheanh
    
    @GetMapping("/test")
	public String test(Model model) {
		List<Product> list = productService.findAll();
		model.addAttribute("list", list);
		return "test";
	}

	
    @GetMapping("/cancel/{orderId}")
	public String cancelOrder(@PathVariable("orderId") Long orderId, RedirectAttributes redirectAttributes) {
	    // Gọi service để hủy đơn hàng
	    String message = orderService.cancelOrder(orderId);

	    // Thêm thông báo vào RedirectAttributes
	    redirectAttributes.addFlashAttribute("message", message);

	    // Chuyển hướng về trang danh sách đơn hàng
	    return "redirect:/buyer/orders/my-orders";
	}

	@GetMapping("/checkout")
	public ModelAndView placeOrder(@RequestParam(name = "listCartIemId") List<Long> listid,
			 ModelMap model) {

		List<CartItem> cart = new ArrayList<>();
		for(Long id : listid) {
			Optional<CartItem> fcart = cartService.findById(id);
			cart.add(fcart.get());
		}
		
		if (cart == null || cart.isEmpty()) {

			model.addAttribute("errorMessage", "No products found for the selected IDs.");
			return new ModelAndView("error", model);
		}

		model.addAttribute("cartList", cart);
		return new ModelAndView("buyer/checkout", model); 
	}
	
	
	@PostMapping("/saveOrder")
	public String checkout(
	        @RequestParam List<Long> productIds,
	        @RequestParam List<Integer> quantities,
	        @RequestParam float totalPrice,
	        @RequestParam List<Double> prices,
	        @RequestParam(value = "CashOnDelivery", required = false) String CashOnDelivery,
	        @RequestParam(value="address",required =false) String address,
	        HttpSession session,
	        Model model) {
	    	
		// Kiểm tra giá trị CashOnDelivery
	    if (CashOnDelivery == null || CashOnDelivery.trim().isEmpty()) {
	    	return "buyer/checkout";
	    }

	    // Kiểm tra giá trị address
	    if (address == null || address.trim().isEmpty()) {
	       
	        return "buyer/checkout";
	    }
	    Long buyerId = getCurrentBuyerId(session);
		    Order order = new Order();
		    order.setOrderAt(LocalDateTime.now());
		    order.setStatus("Pending");
		    order.setPaymentMethod(CashOnDelivery);
		    Buyer buyer = new Buyer();
		    buyer.setId(buyerId);
		    order.setTotalPrice(totalPrice);
		    order.setBuyer(buyer);

		
	    // Tạo danh sách OrderDetail từ các tham số đã nhận
	    List<OrderDetail> orderDetails = new ArrayList<>();
	    for (int i = 0; i < productIds.size(); i++) {
	        OrderDetail orderDetail = new OrderDetail();
	        Product product =new Product();
	        product.setId(productIds.get(i));
	        orderDetail.setProduct(product);
	        orderDetail.setQuantity(quantities.get(i));
	        orderDetail.setPrice(prices.get(i));
	        orderDetail.setOrder(order);
	        orderDetails.add(orderDetail);
	    }
	    order.setItems(orderDetails);

	    // Lưu đơn hàng vào cơ sở dữ liệu
	    try {
	        orderService.placeOrder(order);
	        model.addAttribute("message","Đặt hàng thành công!");
	      
	    } catch (Exception e) {
	    	model.addAttribute("message2",e.getMessage());
	    }

	    return "buyer/checkout";
	}
}