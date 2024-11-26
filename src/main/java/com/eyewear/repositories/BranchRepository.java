package com.eyewear.repositories;

import com.eyewear.entities.Branch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BranchRepository extends JpaRepository<Branch, Long> {
    // Có thể thêm các phương thức tùy chỉnh nếu cần
}