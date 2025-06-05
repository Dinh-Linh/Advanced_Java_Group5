package com.example.advanced_java_group5.controllers.client;

import com.example.advanced_java_group5.services.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/book-table")
public class BookTableController {

    @Autowired
    private ReservationService reservationService;

    @PostMapping
    public String bookTable(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("date") String date,
            @RequestParam("time") String time,
            @RequestParam("people") int numberOfPeople,
            @RequestParam("orderDetails") String orderDetails,
            @RequestParam("orderType") String orderType,
            RedirectAttributes redirectAttributes) {

        // Validate dữ liệu
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                date == null || date.trim().isEmpty() ||
                time == null || time.trim().isEmpty() ||
                orderDetails == null || orderDetails.trim().isEmpty()) {

            redirectAttributes.addFlashAttribute("failMessage", "Vui lòng điền đầy đủ thông tin!");
            return "redirect:/home";
        }

        try {
            boolean success = reservationService.createReservation(
                    name, email, phone, date, time, numberOfPeople, orderDetails, orderType
            );

            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "Đặt bàn thành công!");
            } else {
                redirectAttributes.addFlashAttribute("failMessage", "Bàn đã đầy, đặt bàn không thành công!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("failMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        return "redirect:/home";
    }
}
