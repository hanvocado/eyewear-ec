package com.eyewear.controllers.buyer;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eyewear.DTO.CartItemDTO;
import com.eyewear.entities.Buyer;
import com.eyewear.entities.CartItem;
import com.eyewear.entities.Product;
import com.eyewear.entities.ShoppingCart;
import com.eyewear.services.CartService;
import com.eyewear.services.ProductService;
import com.eyewear.services.impl.CartServiceImpl;
import com.eyewear.services.impl.ProductServiceImpl;

@RequestMapping("/buyer/cart")
@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	@Autowired
	private ProductService productService;
	
	@GetMapping("")
	public String viewCart(Model model,@RequestParam("cartID") Long cartid ) {
		ShoppingCart  cart = cartService.findByCartId(cartid).orElseThrow(() -> new RuntimeException("cart not found"));
	    List<CartItem> cartItems = cart.getCartItems();
	  //  List<CartItemDTO> cartItemDTOs = new ArrayList<>();

//	    for (CartItem item : cartItems) {
//	        Product product = productService.getProductById(item.getProductID());
//	        CartItemDTO dto = new CartItemDTO();
//	        dto.setImage(product.getImage());
//	        dto.setDescription(product.getDescription());
//	        dto.setRefNo(product.getRefNo());
//	        dto.setUnitPrice(product.getUnitPrice());
//	        dto.setQuantity(item.getQuantity());
//	        cartItemDTOs.add(dto);
//	    }

	    model.addAttribute("listCartItem", cartItems);
	    return "buyer/cart";
	}
	@GetMapping("/deleteCartItem")
	public String deleteCart(Model model,@RequestParam("cartItemID") Long cartItemId , RedirectAttributes redirectAttributes) {
	CartItem  cartItem = cartService.findById(cartItemId).orElseThrow(() -> new RuntimeException("cartItem not found"));

	   cartService.delete(cartItem);
	   
	   redirectAttributes.addFlashAttribute("message", "Xóa vật phẩm thành công!");

	   ShoppingCart cart = cartItem.getShoppingCart();
	    // Redirect đến URL /buyer/cart
	   return "redirect:/buyer/cart?cartID=" + cart.getCartId();
	}
	
	@GetMapping("/addCartItem")
	public String addCartItem(@RequestParam("productID") Long productId, Model model) {
		// Tìm sản phẩm dựa trên ID
		Product product = productService.findById(productId);
		if (product != null) {
			
			// Thêm sản phẩm vào giỏ hàng (giả sử CartService có phương thức addItemToCart)
			cartService.addCartItem(null, productId, 1);

		} else {
			// model.addAttribute("error", "Product not found!");
		}

		return "buyer/cart";
	}
}
