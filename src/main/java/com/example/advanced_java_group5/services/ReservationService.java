package com.example.advanced_java_group5.services;

import com.example.advanced_java_group5.models.entities.Reservation;
import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.repositories.ReservationRepository;
import com.example.advanced_java_group5.repositories.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
public class ReservationService {

    private final ReservationRepository reservationRepository;

    private final UserRepository userRepository;

    private BCryptPasswordEncoder passwordEncoder;

    private Timestamp combineDateTime(String date, String time) {
        try {
            if (date == null || date.trim().isEmpty() || time == null || time.trim().isEmpty()) {
                return null;
            }
            if (!date.matches("\\d{4}-\\d{2}-\\d{2}") || !time.matches("\\d{2}:\\d{2}")) {
                return null;
            }
            String dateTimeStr = date + " " + time + ":00";
            return Timestamp.valueOf(dateTimeStr);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Transactional
    public boolean createReservation(String name, String email, String phone, String date, String time,
                                     int numberOfPeople, String orderDetails, String orderType) {
        try {
            // Kiểm tra các trường bắt buộc
            if (name == null || name.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    phone == null || phone.trim().isEmpty() ||
                    date == null || date.trim().isEmpty() ||
                    time == null || time.trim().isEmpty() ||
                    orderDetails == null || orderDetails.trim().isEmpty() ||
                    numberOfPeople <= 0) {
                return false;
            }

            // Tìm hoặc tạo user
            User user = userRepository.findByEmailOrPhone(email.trim(), phone.trim());
            if (user == null) {
                user = new User();
                user.setName(name.trim());
                user.setEmail(email.trim());
                user.setPhone(phone.trim());
                user.setRole("customer");
                user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                user.setPassword(passwordEncoder.encode(phone.trim()));
                user = userRepository.save(user);
            } else if (!user.getName().equals(name.trim())) {
                user.setName(name.trim());
                userRepository.save(user);
            }

            // Parse order details
            List<OrderItem> orderItems = parseOrderDetails(orderDetails.trim());
            if (orderItems.isEmpty()) {
                throw new RuntimeException("Danh sách món ăn không hợp lệ");
            }

            // Tính tổng tiền
            double total = 0.0;
            if ("combo".equals(orderType)) {
                for (OrderItem item : orderItems) {
                    Integer comboId = reservationRepository.getComboIdByName(item.foodName);
                    if (comboId != null) {
                        Double price = reservationRepository.getComboPrice(comboId);
                        if (price != null) {
                            total += price * item.quantity;
                        }
                    }
                }
            } else {
                for (OrderItem item : orderItems) {
                    Integer foodId = reservationRepository.getFoodIdByName(item.foodName);
                    if (foodId != null) {
                        Double price = reservationRepository.getFoodPrice(foodId);
                        if (price != null) {
                            total += price * item.quantity;
                        }
                    }
                }
            }

            // Tạo reservation
            Timestamp reservationDateTime = combineDateTime(date.trim(), time.trim());
            if (reservationDateTime == null) {
                throw new RuntimeException("Thời gian đặt bàn không hợp lệ");
            }

            int reservationId = createReservation(user.getId(), reservationDateTime, numberOfPeople, orderDetails.trim(), total);
            if (reservationId == -1) {
                throw new RuntimeException("Không còn bàn trống trong thời gian này");
            }

            // Lưu chi tiết đơn hàng
            if ("combo".equals(orderType)) {
                for (OrderItem item : orderItems) {
                    Integer comboId = reservationRepository.getComboIdByName(item.foodName);
                    if (comboId != null) {
                        reservationRepository.createReservationCombo(reservationId, comboId, item.quantity);
                    }
                }
            } else {
                for (OrderItem item : orderItems) {
                    Integer foodId = reservationRepository.getFoodIdByName(item.foodName);
                    if (foodId != null) {
                        reservationRepository.createReservationFood(reservationId, foodId, item.quantity);
                    }
                }
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private List<OrderItem> parseOrderDetails(String orderDetails) {
        List<OrderItem> items = new ArrayList<>();
        try {
            if (orderDetails.startsWith("{")) {
                ObjectMapper mapper = new ObjectMapper();
                Map<String, Integer> orderMap = mapper.readValue(orderDetails, Map.class);
                for (Map.Entry<String, Integer> entry : orderMap.entrySet()) {
                    items.add(new OrderItem(entry.getKey(), entry.getValue()));
                }
                return items;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String[] lines = orderDetails.split("\\n");
        Pattern pattern = Pattern.compile("(.*?)\\s*-\\s*(\\d+)\\s*x");
        for (String line : lines) {
            Matcher matcher = pattern.matcher(line.trim());
            if (matcher.find()) {
                String foodName = matcher.group(1).trim();
                int quantity = Integer.parseInt(matcher.group(2));
                items.add(new OrderItem(foodName, quantity));
            }
        }
        return items;
    }

    public List<Reservation> getAllReservations() {
        return reservationRepository.findAll();
    }

    private static class OrderItem {
        String foodName;
        int quantity;

        public OrderItem(String foodName, int quantity) {
            this.foodName = foodName;
            this.quantity = quantity;
        }
    }

    // Gọi phương thức từ ReservationService đã định nghĩa trước
    private int createReservation(Long userId, Timestamp reservationDateTime, int numberOfPeople, String note, double total) {
        return reservationRepository.createReservation(userId, reservationDateTime, numberOfPeople, note, total);
    }
}
