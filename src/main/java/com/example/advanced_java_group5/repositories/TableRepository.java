package com.example.advanced_java_group5.repositories;
import com.example.advanced_java_group5.models.entities.Table;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface TableRepository extends JpaRepository<Table, Integer> {

    // Lấy table theo status
    Page<Table> findByStatus(String status, Pageable pageable);

    // Tìm table theo từ khóa
    @Query("SELECT t FROM Table t WHERE t.name LIKE %:keyword% OR t.location LIKE %:keyword%")
    Page<Table> findByKeyword(@Param("keyword") String keyword, Pageable pageable);

    // Tìm table theo từ khóa và status
    @Query("SELECT t FROM Table t WHERE (t.name LIKE %:keyword% OR t.location LIKE %:keyword%) AND t.status = :status")
    Page<Table> findByKeywordAndStatus(@Param("keyword") String keyword, @Param("status") String status, Pageable pageable);
}