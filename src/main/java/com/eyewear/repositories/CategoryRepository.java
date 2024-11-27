package com.eyewear.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.eyewear.entities.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
}
