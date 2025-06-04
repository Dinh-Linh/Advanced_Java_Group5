package com.example.advanced_java_group5.repositories;
import com.example.advanced_java_group5.models.entities.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReviewRepository extends JpaRepository<Review, Integer> {

    // Lấy review theo customerId
    Page<Review> findByCustomerId(int customerId, Pageable pageable);

    // Lấy review theo rating
    Page<Review> findByRating(int rating, Pageable pageable);
}
