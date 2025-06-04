package com.example.advanced_java_group5.repositories;
import com.example.advanced_java_group5.models.entities.Combo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ComboRepository extends JpaRepository<Combo, Long> {

    // Lấy combo theo status
    Page<Combo> findByStatus(String status, Pageable pageable);

    // Tìm combo theo từ khóa
    @Query("SELECT c FROM Combo c WHERE c.name LIKE %:keyword%")
    Page<Combo> findByKeyword(@Param("keyword") String keyword, Pageable pageable);

    // Tìm combo theo từ khóa và status
    @Query("SELECT c FROM Combo c WHERE c.name LIKE %:keyword% AND c.status = :status")
    Page<Combo> findByKeywordAndStatus(@Param("keyword") String keyword, @Param("status") String status, Pageable pageable);

    // Lấy combo available
    @Query("SELECT c FROM Combo c WHERE c.status = 'available' ORDER BY c.price ASC")
    Page<Combo> findAvailableCombos(Pageable pageable);
}
