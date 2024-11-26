package com.eyewear.repositories;

import com.eyewear.entities.Branch;
import com.eyewear.model.BranchModel;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface BranchRepository extends JpaRepository<Branch, Long> {
	// Query để lấy dữ liệu theo model
    @Query("SELECT new com.eyewear.model.BranchModel(b.id, b.name) FROM Branch b")
    List<BranchModel> findAllBranchModels();
    
    // Hoặc nếu muốn sử dụng Native Query
    @Query(value = "SELECT id, name FROM branches", nativeQuery = true)
    List<Object[]> findAllBranchData();
}