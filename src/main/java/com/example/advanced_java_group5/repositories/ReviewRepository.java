package com.example.advanced_java_group5.repositories;
import com.example.advanced_java_group5.models.entities.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ReviewRepository extends JpaRepository<Review, Long> {

    // Lấy review theo customerId
    Page<Review> findByCustomerId(int customerId, Pageable pageable);

    // Lấy review theo rating
    Page<Review> findByRating(int rating, Pageable pageable);

    @Query("SELECT COUNT(r) FROM Review r WHERE r.id = :foodId")
    long countByFoodId(@Param("foodId") Long foodId);

    @Query("SELECT COUNT(r) FROM Review r WHERE r.id = :userId")
    long countByUserId(@Param("userId") Long userId);
}
