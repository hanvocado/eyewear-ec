package com.eyewear.controllers;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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


@Controller

@RequestMapping("/order")
public class OrderController {

	@Autowired
	OrderService orderService;

	@Autowired
	ProductService productService;
	
	

	@GetMapping("")
	public String index() {
		return "checkout";
	}

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
	public String cancelOrder(@PathVariable("orderId") Long orderId) {
	   
	    orderService.cancelOrder(orderId);

	    return "index"; 
	}

	@GetMapping("/checkout")
	public ModelAndView placeOrder(@RequestParam(name = "selectedProducts") List<Long> listid,
			@RequestParam(name = "buyerId") int buyerId, ModelMap model) {

		List<Product> pro = productService.getProductsById(listid);


		if (pro == null || pro.isEmpty()) {

			model.addAttribute("errorMessage", "No products found for the selected IDs.");
			return new ModelAndView("error", model);
		}



		model.addAttribute("buyerId", buyerId); 
		//model.addAttribute("totalPrice", totalPrice); 
		model.addAttribute("productList", pro);
		return new ModelAndView("checkout", model); 
	}
	
	
	@PostMapping("/saveOrder")
	public ModelAndView checkout(
	        @RequestParam List<Long> productIds,
	        @RequestParam List<Integer> quantities,
	        @RequestParam List<Double> prices,
	        @RequestParam("CashOnDelivery") String CashOnDelivery,
	        @RequestParam("buyerid") String buyerid,
	        ModelMap model) {
	    
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
	    return new ModelAndView("index", model);
	}



	


}
