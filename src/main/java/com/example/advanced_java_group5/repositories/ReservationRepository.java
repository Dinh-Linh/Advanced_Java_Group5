package com.example.advanced_java_group5.repositories;
import com.example.advanced_java_group5.models.entities.Reservation;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;

public interface ReservationRepository extends JpaRepository<Reservation, Integer> {

    // Lấy reservation theo customerId
    Page<Reservation> findByCustomerId(int customerId, Pageable pageable);

    // Lấy reservation theo status
    Page<Reservation> findByStatus(String status, Pageable pageable);

    // Tìm bàn trống
    @Query("SELECT t.id FROM Table t WHERE t.status = 'available' AND t.capacity >= :numberOfPeople " +
            "AND NOT EXISTS (SELECT 1 FROM Reservation r WHERE r.table.id = t.id AND r.status != 'cancelled' " +
            "AND r.reservationAt BETWEEN :startTime AND :endTime) ORDER BY t.capacity ASC")
    Integer findAvailableTable(@Param("numberOfPeople") int numberOfPeople,
                               @Param("startTime") Timestamp startTime,
                               @Param("endTime") Timestamp endTime);

    // Cập nhật trạng thái bàn
    @Modifying
    @Transactional
    @Query("UPDATE Table t SET t.status = :status WHERE t.id = :tableId")
    int updateTableStatus(@Param("tableId") int tableId, @Param("status") String status);

    // Thêm reservation_food
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO reservation_food (reservation_id, food_id, quantity) VALUES (:reservationId, :foodId, :quantity)", nativeQuery = true)
    void createReservationFood(@Param("reservationId") int reservationId, @Param("foodId") int foodId, @Param("quantity") int quantity);

    // Thêm reservation_combo
    @Modifying
    @Transactional
    @Query(value = "INSERT INTO reservation_combo (reservation_id, combo_id, quantity) VALUES (:reservationId, :comboId, :quantity)", nativeQuery = true)
    void createReservationCombo(@Param("reservationId") int reservationId, @Param("comboId") int comboId, @Param("quantity") int quantity);

    // Lấy giá food
    @Query("SELECT f.price FROM Food f WHERE f.id = :foodId")
    Double getFoodPrice(@Param("foodId") int foodId);

    // Lấy foodId theo tên
    @Query("SELECT f.id FROM Food f WHERE f.name = :foodName")
    Integer getFoodIdByName(@Param("foodName") String foodName);

    // Lấy giá combo
    @Query("SELECT c.price FROM Combo c WHERE c.id = :comboId")
    Double getComboPrice(@Param("comboId") int comboId);

    // Lấy comboId theo tên
    @Query("SELECT c.id FROM Combo c WHERE c.name = :comboName")
    Integer getComboIdByName(@Param("comboName") String comboName);
}
