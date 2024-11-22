package com.eyewear.controllers;

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

import com.eyewear.entities.ProductReview;
import com.eyewear.services.ProductReviewService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/reviews")
public class ProductReviewController {
	
	@Autowired
	ProductReviewService reivewService;
	
	@GetMapping("")
	public String review( @RequestParam("buyerId") Long buyerId, @RequestParam("productId") Long productId, Model model) {
	    model.addAttribute("buyerId", buyerId);
	    model.addAttribute("productId", productId);
	    return "review";
	}

	
	@PostMapping("/save")
	public ModelAndView saveOrUpdateReview(ModelMap model,@Valid @ModelAttribute("review") ProductReview review, BindingResult result) {

	    if (result.hasErrors()) {
	        model.addAttribute("message", "Validation errors occurred.");
	        return new ModelAndView("review", model); 
	    }
	    reivewService.save(review);
	    
	    String message = "Review added!";
	    model.addAttribute("message", message);
	    return new ModelAndView("index", model); 
	}
}
