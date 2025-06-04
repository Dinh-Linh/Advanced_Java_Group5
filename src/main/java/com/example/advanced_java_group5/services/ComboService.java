package com.example.advanced_java_group5.services;
import com.example.advanced_java_group5.models.entities.Combo;
import com.example.advanced_java_group5.repositories.ComboRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComboService {

    @Autowired
    private ComboRepository comboRepository;

    public List<Combo> getAllCombos() {
        return comboRepository.findAll();
    }

    public Page<Combo> getCombosByPage(int page, int itemsPerPage) {
        return comboRepository.findAll(PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalCombos() {
        return comboRepository.count();
    }

    public Combo getComboById(Long id) {
        return comboRepository.findById(id).orElse(null);
    }

    public Combo createCombo(Combo combo) {
        return comboRepository.save(combo);
    }

    public Combo updateCombo(Combo combo) {
        if (comboRepository.existsById(combo.getId())) {
            return comboRepository.save(combo);
        }
        return null;
    }

    public void deleteCombo(Long id) {
        comboRepository.deleteById(id);
    }

    public Page<Combo> getCombosByPageAndStatus(int page, int itemsPerPage, String status) {
        return comboRepository.findByStatus(status, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getComboCountByStatus(String status) {
        return comboRepository.countByStatus(status);
    }

    public Page<Combo> findByKeyword(String keyword, int page, int itemsPerPage) {
        return comboRepository.findByKeyword(keyword, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalCombosByKeyword(String keyword) {
        return comboRepository.countByNameContaining(keyword);
    }

    public Page<Combo> findByKeywordAndStatus(String keyword, String status, int page, int itemsPerPage) {
        return comboRepository.findByKeywordAndStatus(keyword, status, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalCombosByKeywordAndStatus(String keyword, String status) {
        return comboRepository.countByNameContainingAndStatus(keyword, status);
    }

    public List<Combo> getAvailableCombos() {
        return comboRepository.findAvailableCombos(PageRequest.of(0, Integer.MAX_VALUE)).getContent();
    }
}
