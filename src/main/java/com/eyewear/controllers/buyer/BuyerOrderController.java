package com.eyewear.controllers.buyer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.Buyer;
import com.eyewear.entities.CartItem;
import com.eyewear.entities.Order;
import com.eyewear.entities.OrderDetail;
import com.eyewear.entities.Product;
import com.eyewear.entities.ProductReview;
import com.eyewear.services.CartService;
import com.eyewear.services.OrderService;
import com.eyewear.services.ProductReviewService;
import com.eyewear.services.ProductService;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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

    private Long getCurrentBuyerId(Principal principal) {
        // TODO: Implement logic to get current buyer id from Principal
        return 1L; // Temporary return
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
	        Principal principal,
	        Model model) {
	    	
		// Kiểm tra giá trị CashOnDelivery
	    if (CashOnDelivery == null || CashOnDelivery.trim().isEmpty()) {
	    	return "buyer/checkout";
	    }

	    // Kiểm tra giá trị address
	    if (address == null || address.trim().isEmpty()) {
	       
	        return "buyer/checkout";
	    }
	    Long buyerId = getCurrentBuyerId(principal);
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
	    	model.addAttribute("message","Đặt hàng thất bại!");
	    }

	    return "buyer/checkout";
	}
}