package com.eyewear.repositories;

import com.eyewear.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    Optional<User> findByEmail(String email);

    User findUserByEmail(String email);

    boolean existsByEmail(String email);

    @Query("SELECT u FROM User u WHERE TYPE(u) = :type")
    List<User> findAllByType(@Param("type") Class<? extends User> type);
}