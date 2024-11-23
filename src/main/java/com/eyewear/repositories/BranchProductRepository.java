package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.eyewear.entities.BranchProduct;

@Repository
public interface BranchProductRepository extends JpaRepository<BranchProduct, Long> {
	BranchProduct findByProductIdAndBranchId(Long productId, Long branchId);
	
	List<BranchProduct> findByBranchId(Long branchId);
}
