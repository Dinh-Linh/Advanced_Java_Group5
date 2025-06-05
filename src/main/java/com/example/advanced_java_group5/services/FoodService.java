package com.example.advanced_java_group5.services;

import com.example.advanced_java_group5.models.entities.Food;
import com.example.advanced_java_group5.repositories.FoodRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoodService {

    @Autowired
    private FoodRepository foodRepository;

    public List<Food> getAllFoods() {
        return foodRepository.findAll();
    }

    public Page<Food> getFoods(int page, int itemsPerPage) {
        return foodRepository.findAll(PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalFoods() {
        return foodRepository.count();
    }

    public Food getFoodById(Long id) {
        return foodRepository.findById(id).orElse(null);
    }

    public Food createFood(Food food) {
        return foodRepository.save(food);
    }

    public Food updateFood(Food food) {
        if (foodRepository.existsById(food.getId())) {
            return foodRepository.save(food);
        }
        return null;
    }

    public void deleteFood(Long id) {
        foodRepository.deleteById(id);
    }

    public List<Food> getByMealType(String mealType) {
        return foodRepository.findByMealType(mealType, PageRequest.of(0, Integer.MAX_VALUE)).getContent();
    }

    public List<Food> getBreakfast() {
        return getByMealType("breakfast");
    }

    public List<Food> getLunch() {
        return getByMealType("lunch");
    }

    public List<Food> getDinner() {
        return getByMealType("dinner");
    }

    public List<Food> getDessert() {
        return getByMealType("dessert");
    }

    public Page<Food> getFoodsByStatus(int page, int itemsPerPage, String status) {
        return foodRepository.findByStatus(status, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getFoodCountByStatus(String status) {
        return foodRepository.countByStatus(status);
    }

    public Page<Food> getFoodsByStatusAndMealType(int page, int itemsPerPage, String status, String mealType) {
        return foodRepository.findByStatusAndMealType(status, mealType, PageRequest.of(page - 1, itemsPerPage));
    }

//    public long getFoodCountByStatusAndMealType(String status, String mealType) {
//        return foodRepository.countByStatusAndMealType(status, mealType);
//    }

    public Page<Food> getFoodsByMealType(int page, int itemsPerPage, String mealType) {
        return foodRepository.findByMealType(mealType, PageRequest.of(page - 1, itemsPerPage));
    }

//    public long getFoodCountByMealType(String mealType) {
//        return foodRepository.countByMealType(mealType);
//    }

    public Page<Food> findByKeyword(String keyword, int page, int itemsPerPage) {
        return foodRepository.findByKeyword(keyword, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalFoodsByKeyword(String keyword) {
        return foodRepository.countByNameContaining(keyword);
    }

    public Page<Food> findByKeywordAndStatus(String keyword, String status, int page, int itemsPerPage) {
        return foodRepository.findByKeywordAndStatus(keyword, status, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalFoodsByKeywordAndStatus(String keyword, String status) {
        return foodRepository.countByNameContainingAndStatus(keyword, status);
    }

    public Page<Food> findByKeywordAndMealType(String keyword, String mealType, int page, int itemsPerPage) {
        return foodRepository.findByKeywordAndMealType(keyword, mealType, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalFoodsByKeywordAndMealType(String keyword, String mealType) {
        return foodRepository.countByNameContainingAndMealType(keyword, mealType);
    }

    public Page<Food> findByKeywordAndStatusAndMealType(String keyword, String status, String mealType, int page, int itemsPerPage) {
        return foodRepository.findByKeywordAndStatusAndMealType(keyword, status, mealType, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalFoodsByKeywordAndStatusAndMealType(String keyword, String status, String mealType) {
        return foodRepository.countByNameContainingAndStatusAndMealType(keyword, status, mealType);
    }

    public List<Food> getFirst6Foods() {
        return foodRepository.findFirst6Foods(PageRequest.of(0, 6)).getContent();
    }

    public List<Food> get6FoodsByMealType(String mealType) {
        return foodRepository.find6FoodsByMealType(mealType, PageRequest.of(0, 6)).getContent();
    }
}
