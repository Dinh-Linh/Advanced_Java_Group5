package com.example.advanced_java_group5.controllers.admin;

import com.example.advanced_java_group5.models.entities.Food;
import com.example.advanced_java_group5.services.FoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/foods")
public class FoodController {

    private static final int ITEMS_PER_PAGE = 10;

    @Autowired
    private FoodService foodService;

    @GetMapping({"", "/"})
    public String listFoods(Model model,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "itemsPerPage", defaultValue = "" + ITEMS_PER_PAGE) int itemsPerPage,
                            @RequestParam(value = "status", required = false) String status,
                            @RequestParam(value = "mealType", required = false) String mealType,
                            @RequestParam(value = "keyword", required = false) String keyword) {
        Page<Food> foodPage;
        boolean hasKeyword = keyword != null && !keyword.isEmpty();
        boolean hasStatus = status != null && !status.equals("all");
        boolean hasMealType = mealType != null && !mealType.equals("all");

        if (hasKeyword && hasStatus && hasMealType) {
            foodPage = foodService.findByKeywordAndStatusAndMealType(keyword, status, mealType, page, itemsPerPage);
        } else if (hasKeyword && hasStatus) {
            foodPage = foodService.findByKeywordAndStatus(keyword, status, page, itemsPerPage);
        } else if (hasKeyword && hasMealType) {
            foodPage = foodService.findByKeywordAndMealType(keyword, mealType, page, itemsPerPage);
        } else if (hasStatus && hasMealType) {
            foodPage = foodService.getFoodsByStatusAndMealType(page, itemsPerPage, status, mealType);
        } else if (hasKeyword) {
            foodPage = foodService.findByKeyword(keyword, page, itemsPerPage);
        } else if (hasStatus) {
            foodPage = foodService.getFoodsByStatus(page, itemsPerPage, status);
        } else if (hasMealType) {
            foodPage = foodService.getFoodsByMealType(page, itemsPerPage, mealType);
        } else {
            foodPage = foodService.getFoods(page, itemsPerPage);
        }

        setPaginationAttributes(model, foodPage, page, itemsPerPage);
        model.addAttribute("foods", foodPage.getContent());
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedMealType", mealType);
        model.addAttribute("keyword", keyword);
        model.addAttribute("title", "Danh sách món ăn");
        return "admin/foods/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("title", "Thêm món ăn");
        model.addAttribute("food", new Food());
        return "admin/foods/add";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Food food = foodService.getFoodById(id);
        if (food == null) {
            return "redirect:/admin/foods?error=Food not found";
        }
        model.addAttribute("food", food);
        model.addAttribute("title", "Chỉnh sửa món ăn " + food.getName());
        return "admin/foods/edit";
    }

    @GetMapping("/{id}")
    public String showDetail(@PathVariable("id") Long id, Model model) {
        Food food = foodService.getFoodById(id);
        if (food == null) {
            return "redirect:/admin/foods?error=Food not found";
        }
        model.addAttribute("food", food);
        model.addAttribute("title", "Món ăn " + food.getName());
        return "admin/foods/detail";
    }

    @PostMapping
    public String createFood(@ModelAttribute Food food, RedirectAttributes redirectAttributes) {
        try {
            foodService.createFood(food);
            redirectAttributes.addFlashAttribute("message", "Thêm món ăn thành công");
            return "redirect:/admin/foods";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm món ăn thất bại");
            return "redirect:/admin/foods/add";
        }
    }

    @PostMapping("/{id}")
    public String updateFood(@PathVariable("id") Long id, @ModelAttribute Food food, RedirectAttributes redirectAttributes) {
        try {
            food.setId(id);
            foodService.updateFood(food);
            redirectAttributes.addFlashAttribute("message", "Cập nhật món ăn thành công");
            return "redirect:/admin/foods";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật món ăn thất bại");
            return "redirect:/admin/foods/" + id + "/edit";
        }
    }

    @DeleteMapping("/{id}")
    public String deleteFood(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            foodService.deleteFood(id);
            redirectAttributes.addFlashAttribute("message", "Xóa món ăn thành công");
            return "redirect:/admin/foods";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa món ăn thất bại");
            return "redirect:/admin/foods";
        }
    }

    private void setPaginationAttributes(Model model, Page<?> page, int currentPage, int itemsPerPage) {
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("itemsPerPage", itemsPerPage);
    }
}
