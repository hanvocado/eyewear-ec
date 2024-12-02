
package com.eyewear.controllers.buyer;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.eyewear.entities.Buyer;
import com.eyewear.entities.CartItem;
import com.eyewear.entities.Product;
import com.eyewear.entities.ShoppingCart;
import com.eyewear.services.BuyerService;
import com.eyewear.services.CartService;
import com.eyewear.services.ProductService;

@RequestMapping("/buyer/cart")
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	@Autowired
	private ProductService productService;
	@Autowired
	private BuyerService buyerService;
	@GetMapping("")
	public String viewCart(Model model, @RequestParam(name = "cartID", required = false) Long cartid) {
		if (cartid == null) {
			// Xử lý trường hợp cartID không có trong request
			throw new RuntimeException("cartID is required");
		}
		ShoppingCart cart = cartService.findByCartId(cartid).orElseThrow(() -> new RuntimeException("cart not found"));
		List<CartItem> cartItems = cart.getCartItems();

		model.addAttribute("listCartItem", cartItems);
		return "buyer/cart";
	}

	@PostMapping("/updateQuantity")
	public ResponseEntity<?> updateQuantity(@RequestBody Map<String, Object> request) {
	    Long cartItemId = Long.valueOf(request.get("cartItemId").toString());
	    int quantity = Integer.parseInt(request.get("quantity").toString());

	    try {
	        cartService.updateQuantity(cartItemId, quantity);
	        return ResponseEntity.ok(Map.of("success", true, "message", "Quantity updated successfully!"));
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(
	            Map.of("success", false, "message", e.getMessage())
	        );
	    }
	}


//	@ModelAttribute("cartTotalValue")
//	public double calculateCartTotalValue(@ModelAttribute("cartItemsForCartIcon") List<CartItem> cartItems) {
//		return cartItems.stream().mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity()).sum();
//	}

	@GetMapping("/deleteCartItem")
	public String deleteCart(Model model, @RequestParam("cartItemID") Long cartItemId,
			RedirectAttributes redirectAttributes) {
		CartItem cartItem = cartService.findById(cartItemId)
				.orElseThrow(() -> new RuntimeException("cartItem not found"));

		cartService.delete(cartItem);

		redirectAttributes.addFlashAttribute("message", "Xóa vật phẩm thành công!");

		ShoppingCart cart = cartItem.getShoppingCart();
		// Redirect đến URL /buyer/cart
		return "redirect:/buyer/cart?cartID=" + cart.getCartId();
	}

	@GetMapping("/addCartItem")
	public String addCartItem(@RequestParam("productID") Long productId, Model model,RedirectAttributes redirectAttributes) {
		// Tìm sản phẩm dựa trên ID
		Product product = productService.findById(productId);
		Buyer buyer = buyerService.findById(1L).orElseThrow(() -> new RuntimeException("Buyer not found"));
		if (product != null) {
			
			// Thêm sản phẩm vào giỏ hàng
			cartService.addCartItem(buyer, productId, 1);
			redirectAttributes.addFlashAttribute("successMessage", "Thêm vật phẩm thành công!");
		} else {
			// model.addAttribute("error", "Product not found!");
			  redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm không tìm thấy!");
		}

		//return "redirect:/buyer/cart?cartID="+ buyer.getShoppingCart().getCartId();
		return "redirect:/common/products";
	}
}
