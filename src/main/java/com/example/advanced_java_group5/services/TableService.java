package com.example.advanced_java_group5.services;
import com.example.advanced_java_group5.models.entities.Table;
import com.example.advanced_java_group5.repositories.TableRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableService {

    @Autowired
    private TableRepository tableRepository;

    public List<Table> getAllTables() {
        return tableRepository.findAll();
    }

    public Page<Table> getTablesByPage(int page, int itemsPerPage) {
        return tableRepository.findAll(PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalTables() {
        return tableRepository.count();
    }

    public Table getTableById(Long id) {
        return tableRepository.findById(id).orElse(null);
    }

    public Table createTable(Table table) {
        return tableRepository.save(table);
    }

    public Table updateTable(Table table) {
        if (tableRepository.existsById(table.getId())) {
            return tableRepository.save(table);
        }
        return null;
    }

    public void deleteTable(Long id) {
        tableRepository.deleteById(id);
    }

    public List<Table> getTablesByStatus(String status) {
        return tableRepository.findByStatus(status, PageRequest.of(0, Integer.MAX_VALUE)).getContent();
    }

    public Page<Table> getTablesByPageAndStatus(int page, int itemsPerPage, String status) {
        return tableRepository.findByStatus(status, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTableCountByStatus(String status) {
        return tableRepository.countByStatus(status);
    }

    public Page<Table> findByKeyword(String keyword, int page, int itemsPerPage) {
        return tableRepository.findByKeyword(keyword, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalTablesByKeyword(String keyword) {
        return tableRepository.countByNameContainingOrLocationContaining(keyword, keyword);
    }

    public Page<Table> findByKeywordAndStatus(String keyword, String status, int page, int itemsPerPage) {
        return tableRepository.findByKeywordAndStatus(keyword, status, PageRequest.of(page - 1, itemsPerPage));
    }

    public long getTotalTablesByKeywordAndStatus(String keyword, String status) {
        return tableRepository.countByNameContainingOrLocationContainingAndStatus(keyword, keyword, status);
    }
}
