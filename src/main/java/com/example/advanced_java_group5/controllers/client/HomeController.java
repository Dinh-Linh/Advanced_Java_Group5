package com.example.advanced_java_group5.controllers.client;

import com.example.advanced_java_group5.models.entities.Combo;
import com.example.advanced_java_group5.models.entities.Food;
import com.example.advanced_java_group5.services.ComboService;
import com.example.advanced_java_group5.services.FoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    private FoodService foodService;

    @Autowired
    private ComboService comboService;

    @GetMapping
    public String showHomePage(Model model) {
        try {
            // Lấy 6 món ăn cho phần gợi ý
            List<Food> suggestedFoods = foodService.getFirst6Foods();
            model.addAttribute("foods", suggestedFoods);

            // Lấy 6 món ăn cho bữa sáng
            List<Food> breakfastFoods = foodService.get6FoodsByMealType("breakfast");
            model.addAttribute("foodsbr", breakfastFoods);

            // Lấy 6 món ăn cho bữa trưa
            List<Food> lunchFoods = foodService.get6FoodsByMealType("lunch");
            model.addAttribute("foodslu", lunchFoods);

            // Lấy 6 món ăn cho bữa tối
            List<Food> dinnerFoods = foodService.get6FoodsByMealType("dinner");
            model.addAttribute("foodsdn", dinnerFoods);

            // Lấy danh sách combo
            List<Combo> combos = comboService.getAvailableCombos();
            model.addAttribute("combos", combos);

            return "client/index";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage());
            return "client/index";
        }
    }
}
