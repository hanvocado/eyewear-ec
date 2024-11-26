package com.eyewear.services.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.eyewear.entities.Buyer;
import com.eyewear.entities.CartItem;
import com.eyewear.entities.Product;
import com.eyewear.entities.ShoppingCart;
import com.eyewear.repositories.CartItemRepository;
import com.eyewear.repositories.ProductRepository;
import com.eyewear.repositories.ShoppingCartRepository;
import com.eyewear.services.CartService;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	CartItemRepository cartItemRepository;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
    private ShoppingCartRepository cartRepository;
	
	@Override
	public Optional<ShoppingCart> findByCartId(Long cartID) {
		return cartRepository.findByCartId(cartID);
	}

	@Override
	public int updateQuantity(Long cartItemId, int quantity) {
		return cartItemRepository.updateQuantity(cartItemId, quantity);
	}

	@Override
	public ShoppingCart getOrCreateCart(Buyer buyer) {
		return cartRepository.findByBuyer(buyer).orElseGet(() -> {
			// Tạo giỏ hàng mới nếu chưa có
			ShoppingCart newCart = new ShoppingCart();
			newCart.setBuyer(buyer);
			return cartRepository.save(newCart);
		});
	}

	@Override
	public void addCartItem(Buyer buyer, Long productId, int quantity) {
		// Lấy hoặc tạo Cart của User
		ShoppingCart cart = getOrCreateCart(buyer);

		// Tìm sản phẩm
		Product product = productRepository.findById(productId)
				.orElseThrow(() -> new RuntimeException("Product not found"));

		// Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
		Optional<CartItem> existingCartItem = cartItemRepository.findByShoppingCartAndProduct(cart, product);

		if (existingCartItem.isPresent()) {
			// Cập nhật số lượng nếu sản phẩm đã tồn tại
			CartItem cartItem = existingCartItem.get();
			cartItem.setQuantity(cartItem.getQuantity() + quantity);
			cartItemRepository.save(cartItem);
		} else {
			// Thêm mới sản phẩm vào giỏ hàng
			CartItem cartItem = new CartItem();
			cartItem.setShoppingCart(cart);
			cartItem.setProduct(product);
			cartItem.setQuantity(quantity);
			cartItemRepository.save(cartItem);
		}
	}

	

	public Optional<CartItem> findByShoppingCartAndProduct(ShoppingCart cart, Product product) {
		return cartItemRepository.findByShoppingCartAndProduct(cart, product);
	}

	@Override
	public <S extends CartItem> S save(S entity) {
		return cartItemRepository.save(entity);
	}

	@Override
	public List<CartItem> findAll(Sort sort) {
		return cartItemRepository.findAll(sort);
	}

	@Override
	public Page<CartItem> findAll(Pageable pageable) {
		return cartItemRepository.findAll(pageable);
	}

	@Override
	public List<CartItem> findAll() {
		return cartItemRepository.findAll();
	}

	@Override
	public Optional<CartItem> findById(Long id) {
		return cartItemRepository.findById(id);
	}

	@Override
	public long count() {
		return cartItemRepository.count();
	}



	

	@Override
	public void deleteAll() {
		cartItemRepository.deleteAll();
	}

	@Override
	public void cartItem(CartItem entity) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteById(Long id) {
		cartItemRepository.deleteById(id);
	}

	@Override
	public void delete(CartItem entity) {
		cartItemRepository.delete(entity);
	}

	

}
