package com.example.advanced_java_group5.controllers.admin;

import com.example.advanced_java_group5.models.entities.Table;
import com.example.advanced_java_group5.services.TableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/tables")
public class TableController {

    private static final int ITEMS_PER_PAGE = 10;

    @Autowired
    private TableService tableService;

    @GetMapping({"", "/"})
    public String listTables(Model model,
                             @RequestParam(value = "page", defaultValue = "1") int page,
                             @RequestParam(value = "itemsPerPage", defaultValue = "" + ITEMS_PER_PAGE) int itemsPerPage,
                             @RequestParam(value = "status", required = false) String status,
                             @RequestParam(value = "keyword", required = false) String keyword) {
        Page<Table> tablePage;
        boolean hasKeyword = keyword != null && !keyword.isEmpty();
        boolean hasStatus = status != null && !status.equals("all");

        if (hasKeyword && hasStatus) {
            tablePage = tableService.findByKeywordAndStatus(keyword, status, page, itemsPerPage);
        } else if (hasKeyword) {
            tablePage = tableService.findByKeyword(keyword, page, itemsPerPage);
        } else if (hasStatus) {
            tablePage = tableService.getTablesByPageAndStatus(page, itemsPerPage, status);
        } else {
            tablePage = tableService.getTablesByPage(page, itemsPerPage);
        }

        setPaginationAttributes(model, tablePage, page, itemsPerPage);
        model.addAttribute("tables", tablePage.getContent());
        model.addAttribute("selectedStatus", status);
        model.addAttribute("keyword", keyword);
        model.addAttribute("title", "Danh sách bàn");
        return "admin/tables/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("title", "Thêm bàn");
        model.addAttribute("table", new Table());
        return "admin/tables/add";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Table table = tableService.getTableById(id);
        if (table == null) {
            return "redirect:/admin/tables?error=Table not found";
        }
        model.addAttribute("table", table);
        model.addAttribute("title", "Chỉnh sửa bàn " + table.getName());
        return "admin/tables/edit";
    }

    @GetMapping("/{id}")
    public String showDetail(@PathVariable("id") Long id, Model model) {
        Table table = tableService.getTableById(id);
        if (table == null) {
            return "redirect:/admin/tables?error=Table not found";
        }
        model.addAttribute("table", table);
        model.addAttribute("title", "Bàn " + table.getName());
        return "admin/tables/detail";
    }

    @PostMapping
    public String createTable(@ModelAttribute Table table, RedirectAttributes redirectAttributes) {
        try {
            tableService.createTable(table);
            redirectAttributes.addFlashAttribute("message", "Thêm bàn thành công");
            return "redirect:/admin/tables";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm bàn thất bại");
            return "redirect:/admin/tables/add";
        }
    }

    @PostMapping("/{id}")
    public String updateTable(@PathVariable("id") Long id, @ModelAttribute Table table, RedirectAttributes redirectAttributes) {
        try {
            table.setId(id);
            tableService.updateTable(table);
            redirectAttributes.addFlashAttribute("message", "Cập nhật bàn thành công");
            return "redirect:/admin/tables";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật bàn thất bại");
            return "redirect:/admin/tables/" + id + "/edit";
        }
    }

    @DeleteMapping("/{id}")
    public String deleteTable(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            tableService.deleteTable(id);
            redirectAttributes.addFlashAttribute("message", "Xóa bàn thành công");
            return "redirect:/admin/tables";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa bàn thất bại");
            return "redirect:/admin/tables";
        }
    }

    private void setPaginationAttributes(Model model, Page<?> page, int currentPage, int itemsPerPage) {
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("itemsPerPage", itemsPerPage);
    }
}
