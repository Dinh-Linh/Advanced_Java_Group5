package com.example.advanced_java_group5.repositories;
import com.example.advanced_java_group5.models.entities.Food;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface FoodRepository extends JpaRepository<Food, Long> {

    // Lấy food theo mealType
    Page<Food> findByMealType(String mealType, Pageable pageable);

    // Lấy food theo status
    Page<Food> findByStatus(String status, Pageable pageable);

    // Lấy food theo status và mealType
    Page<Food> findByStatusAndMealType(String status, String mealType, Pageable pageable);

    // Tìm food theo từ khóa
    @Query("SELECT f FROM Food f WHERE f.name LIKE %:keyword%")
    Page<Food> findByKeyword(@Param("keyword") String keyword, Pageable pageable);

    // Tìm food theo từ khóa và status
    @Query("SELECT f FROM Food f WHERE f.name LIKE %:keyword% AND f.status = :status")
    Page<Food> findByKeywordAndStatus(@Param("keyword") String keyword, @Param("status") String status, Pageable pageable);

    // Tìm food theo từ khóa và mealType
    @Query("SELECT f FROM Food f WHERE f.name LIKE %:keyword% AND f.mealType = :mealType")
    Page<Food> findByKeywordAndMealType(@Param("keyword") String keyword, @Param("mealType") String mealType, Pageable pageable);

    // Tìm food theo từ khóa, status, và mealType
    @Query("SELECT f FROM Food f WHERE f.name LIKE %:keyword% AND f.status = :status AND f.mealType = :mealType")
    Page<Food> findByKeywordAndStatusAndMealType(@Param("keyword") String keyword, @Param("status") String status, @Param("mealType") String mealType, Pageable pageable);

    // Lấy 6 food đầu tiên
    @Query("SELECT f FROM Food f WHERE f.status = 'available' ORDER BY f.id ASC")
    Page<Food> findFirst6Foods(Pageable pageable);

    // Lấy 6 food theo mealType
    @Query("SELECT f FROM Food f WHERE f.status = 'available' AND f.mealType = :mealType ORDER BY f.id ASC")
    Page<Food> find6FoodsByMealType(@Param("mealType") String mealType, Pageable pageable);

    @Query("SELECT COUNT(f) FROM Food f WHERE f.status = :status")
    long countByStatus(@Param("status") String status);

    @Query("SELECT COUNT(f) FROM Food f WHERE f.name LIKE %:keyword%")
    long countByNameContaining(@Param("keyword") String keyword);

    @Query("SELECT COUNT(f) FROM Food f WHERE f.name LIKE %:keyword% AND f.status = :status")
    long countByNameContainingAndStatus(@Param("keyword") String keyword, @Param("status") String status);

    @Query("SELECT COUNT(f) FROM Food f WHERE f.name LIKE %:keyword% AND f.mealType = :mealType")
    long countByNameContainingAndMealType(@Param("keyword") String keyword, @Param("mealType") String mealType);

    @Query("SELECT COUNT(f) FROM Food f WHERE f.name LIKE %:keyword% AND f.status = :status AND f.mealType = :mealType")
    long countByNameContainingAndStatusAndMealType(@Param("keyword") String keyword, @Param("status") String status, @Param("mealType") String mealType);
}
