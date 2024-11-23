package com.eyewear.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    
    @Query("SELECT o FROM Order o WHERE o.buyer.id = :buyerId ORDER BY o.orderAt DESC")
    List<Order> findAllByBuyerId(@Param("buyerId") Long buyerId);

    @Query("SELECT o FROM Order o " +
           "LEFT JOIN FETCH o.items i " +
           "LEFT JOIN FETCH i.product p " +
           "WHERE o.orderId = :orderId AND o.buyer.id = :buyerId")
    Optional<Order> findOrderDetailByIdAndBuyerId(
        @Param("orderId") Long orderId, 
        @Param("buyerId") Long buyerId
    );
}