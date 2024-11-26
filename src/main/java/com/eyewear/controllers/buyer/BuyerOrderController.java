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

import com.eyewear.entities.Buyer;
import com.eyewear.entities.Order;
import com.eyewear.entities.OrderDetail;
import com.eyewear.entities.Product;
import com.eyewear.services.OrderService;
import com.eyewear.services.ProductService;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/buyer/orders")  // Thêm prefix /buyer để phân biệt với admin
public class BuyerOrderController {
    
    @Autowired
    private OrderService orderService;
    @Autowired
	ProductService productService;
    
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
    
    
    //trantheanh
    
    @GetMapping("/test")
	public String test(Model model) {
		List<Product> list = productService.findAll();
		model.addAttribute("list", list);
		return "test";
	}

	@GetMapping("/getorder")
	public String getorder(Model model) {
		List<Order> orders = orderService.getOrdersByBuyer((long) 1);
        model.addAttribute("orders", orders);
        return "test";
	}
	
	@GetMapping("/cancel/{orderId}")
	public String cancelOrder(@PathVariable("orderId") Long orderId,Model model) {
	   
	    String message = orderService.cancelOrder(orderId);
	    
	    model.addAttribute("message",message);
	    return "redirect:/buyer/orders/my-orders"; 
	}

	@GetMapping("/checkout")
	public ModelAndView placeOrder(@RequestParam(name = "selectedProducts") List<Long> listid,
			@RequestParam(name = "buyerId") int buyerId, ModelMap model) {

		List<Product> pro = productService.getProductsById(listid);
		//List<String>

		if (pro == null || pro.isEmpty()) {

			model.addAttribute("errorMessage", "No products found for the selected IDs.");
			return new ModelAndView("error", model);
		}



		model.addAttribute("buyerId", buyerId); 
		//model.addAttribute("totalPrice", totalPrice); 
		model.addAttribute("productList", pro);
		return new ModelAndView("buyer/checkout", model); 
	}
	
	
	@PostMapping("/saveOrder")
	public ModelAndView checkout(
	        @RequestParam List<Long> productIds,
	        @RequestParam List<Integer> quantities,
	        @RequestParam List<Double> prices,
	        @RequestParam(value = "CashOnDelivery", required = false) String CashOnDelivery,
	        @RequestParam(value="address",required =false) String address,
	        @RequestParam("buyerid") String buyerid,
	        ModelMap model) {
	    	
		// Kiểm tra giá trị CashOnDelivery
	    if (CashOnDelivery == null || CashOnDelivery.trim().isEmpty()) {
	    	return new ModelAndView("buyer/checkout",model);
	    }

	    // Kiểm tra giá trị address
	    if (address == null || address.trim().isEmpty()) {
	       
	        return new ModelAndView("buyer/checkout", model);
	    }
		    Order order = new Order();
		    order.setOrderAt(LocalDateTime.now());
		    order.setStatus("Pending");
		    order.setPaymentMethod(CashOnDelivery);
		    Buyer buyer = new Buyer();
		    buyer.setId(Long.parseLong(buyerid));
		    //order.setTotalPrice(0);
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
	    orderService.placeOrder(order);
	    model.addAttribute("message", "Order placed successfully!");
	    return new ModelAndView("redirect:/buyer/orders/my-orders", model);
	}



	
}