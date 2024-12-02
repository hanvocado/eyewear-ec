package com.eyewear.controllers.buyer; 

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.entities.Buyer;
import com.eyewear.entities.Product;
import com.eyewear.entities.ProductReview;
import com.eyewear.services.ProductReviewService;
import com.eyewear.services.ProductService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/buyer/reviews")
public class ProductReviewController {
	
	@Autowired
	ProductReviewService reviewService;
	@Autowired
	ProductService productService;
	
	@GetMapping("test")
	public String index() {
		return "test2";
	}
	
	
	@GetMapping("/getReviews")
    public String getReviews(
            @RequestParam Long productId,
            @RequestParam(required = false) Integer rating,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "1") int size,
            Model model) {
        
		 Page<ProductReview> reviewPage = reviewService.findAll(PageRequest.of(page, size), productId, rating);
	        
	        model.addAttribute("reviews", reviewPage.getContent());
	        model.addAttribute("currentPage", page);
	        model.addAttribute("totalPages", reviewPage.getTotalPages());
	        model.addAttribute("rating", rating);
	        model.addAttribute("productId", productId);
        
        return "test2";
    }
	
	
	@GetMapping("")
	public String review(@RequestParam("productId") Long productId, @RequestParam("orderId") Long orderId, Model model,Principal principal) {
		Long buyerId = getCurrentBuyerId(principal);
	    Product product = productService.findById(productId);
	    
	   Optional<ProductReview> review = reviewService.getReviewByBuyerAndProduct(buyerId, productId);
        
        if (review.isPresent()) {
        	ProductReview review2 =review.get();
        	model.addAttribute("review",review2);
        }
	    model.addAttribute("product", product);
	    model.addAttribute("buyerId",buyerId);
	    model.addAttribute("orderId",orderId);
	    return "buyer/product-review";
	}
	
	private Long getCurrentBuyerId(Principal principal) {
        // TODO: Implement logic to get current buyer id from Principal
        return 1L; // Temporary return
    }

	
	@PostMapping("/save")
	public String saveOrUpdateReview(RedirectAttributes redirectAttributes, @Valid @ModelAttribute("review") ProductReview review,
			Principal principal, @RequestParam("productId") Long productId, @RequestParam("orderId") Long orderId,
	        BindingResult result) {

	    // Kiểm tra lỗi xác thực
	    if (result.hasErrors()) {
	    	redirectAttributes.addAttribute("message", "Validation errors occurred.");
	        return "review"; 
	    }
	    Long buyerId = getCurrentBuyerId(principal);
	    // Tạo đối tượng Buyer và Product từ buyerId và productId
	    Buyer buyer = new Buyer();
	    buyer.setId(buyerId);
	    Product product = new Product();
	    product.setId(productId);
	    review.setBuyer(buyer);
	    review.setProduct(product);
	    review.setReviewDate(LocalDate.now());

	    // Kiểm tra xem bài đánh giá đã tồn tại chưa
	    Optional<ProductReview> Reviewold = reviewService.getReviewByBuyerAndProduct(buyerId, productId);
	    
	    if (Reviewold.isPresent()) {
	    	ProductReview existingReview =Reviewold.get();
	        existingReview.setRating(review.getRating());
	        existingReview.setReviewContent(review.getReviewContent());
	        existingReview.setReviewDate(LocalDate.now());
	        reviewService.save(existingReview);  // Cập nhật vào cơ sở dữ liệu
	        redirectAttributes.addFlashAttribute("message", "Đã cập nhật đánh giá!");
	    } else {
	        // Thêm mới review nếu chưa tồn tại
	    	reviewService.save(review);  // Thêm mới vào cơ sở dữ liệu
	    	redirectAttributes.addFlashAttribute("message", "Cảm ơn bạn đã đánh giá về sản phẩm của chúng tôi !");
	    }

	    return "redirect:/buyer/reviews?orderId=" + orderId 
	    	    + "&buyerId=" + buyerId 
	    	    + "&productId=" + product.getId();

	}

}
