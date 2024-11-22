package com.eyewear.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eyewear.entities.Order;
import com.eyewear.entities.Product;
import com.eyewear.services.OrderService;
import com.eyewear.services.ProductService;

import jakarta.validation.Valid;

@Controller

@RequestMapping("/checkout")
public class OrderController {

	@Autowired
	OrderService orderService;

	@Autowired
	ProductService productService;

	@GetMapping("/checkout")
	public ModelAndView placeOrder(@RequestParam(name = "selectedProducts") List<Long> selectedProducts,
	                               @RequestParam(name = "buyerId") int buyerId, // Lấy buyerId từ request
	                               ModelMap model) {
	    
	    // Lấy danh sách sản phẩm đã chọn
	    //List<Product> selectedProductList = productService.getProductsById(selectedProducts);

	    // Tính tổng giá
	   // double totalPrice = selectedProductList.stream()
	                                      //     .mapToDouble(Product::getPrice) // Lấy giá của từng sản phẩm
	                                       //    .sum(); // Tính tổng
	    List<Product> selectedProductList = null;

	    // Tính tổng giá
	    double totalPrice = 0; // Tính tổng

	    // Thêm thông tin vào model
	    model.addAttribute("productList", selectedProductList);
	    model.addAttribute("buyerId", buyerId);
	    model.addAttribute("totalPrice", totalPrice); // Đẩy tổng giá ra view

	    return new ModelAndView("index", model);
	}

	@PostMapping("/orders")
	public ModelAndView checkout(ModelMap model, @Valid @ModelAttribute("order") Order order, BindingResult result) {

		if (result.hasErrors()) {
			model.addAttribute("message", "Validation errors occurred.");
			return new ModelAndView("index", model); // Trả về form để sửa lỗi
		}
		orderService.placeOrder(order);

		String message = "Success";
		model.addAttribute("message", message);
		return new ModelAndView("index", model); // Điều hướng về trang index
	}
}
