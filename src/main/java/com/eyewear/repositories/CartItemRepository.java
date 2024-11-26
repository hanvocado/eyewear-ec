package com.eyewear.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.CartItem;
import com.eyewear.entities.Product;
import com.eyewear.entities.ShoppingCart;


@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
	// Tìm CartItem dựa vào Cart và Product (nếu cần kiểm tra xem item đã tồn tại trong giỏ hàng chưa)
    Optional<CartItem> findByShoppingCartAndProduct(ShoppingCart cart, Product product);
    

}
