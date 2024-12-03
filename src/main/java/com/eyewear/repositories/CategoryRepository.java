package com.eyewear.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.eyewear.entities.Category;
import com.eyewear.entities.Product;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
   
}
