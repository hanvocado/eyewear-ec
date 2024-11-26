package com.eyewear.repositories;

import java.time.LocalDateTime;
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
    
    List<Order> findAllByOrderByOrderAtDesc();
    
    
    @Query("SELECT DISTINCT o FROM Order o " +
            "LEFT JOIN FETCH o.items items " +
            "LEFT JOIN items.product p " +
            "LEFT JOIN BranchProduct bp ON bp.product = p " +
            "LEFT JOIN bp.branch b " +
            "WHERE (:branchId IS NULL OR b.id = :branchId) AND " +
            "(:productId IS NULL OR p.id = :productId) AND " +
            "o.orderAt BETWEEN :startDate AND :endDate AND " +
            "o.status = 'Đã giao' " +
            "GROUP BY o")
     List<Order> findOrdersForReport(
         @Param("branchId") Long branchId,
         @Param("productId") Long productId,
         @Param("startDate") LocalDateTime startDate,
         @Param("endDate") LocalDateTime endDate
     );

}