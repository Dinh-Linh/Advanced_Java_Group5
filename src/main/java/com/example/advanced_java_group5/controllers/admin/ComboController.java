package com.example.advanced_java_group5.controllers.admin;

import com.example.advanced_java_group5.models.entities.Combo;
import com.example.advanced_java_group5.services.ComboService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/combos")
public class ComboController {

    private static final Logger logger = LoggerFactory.getLogger(ComboController.class);
    private static final int ITEMS_PER_PAGE = 10;

    private final ComboService comboService;

    @Autowired
    public ComboController(ComboService comboService) {
        this.comboService = comboService;
    }

    @GetMapping({"", "/"})
    public String listCombos(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "itemsPerPage", defaultValue = "10") int itemsPerPage,
            @RequestParam(value = "status", required = false) String status,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model,
            HttpSession session
    ) {
        try {
            int currentPage = page < 1 ? 1 : page;
            int itemsPerPageActual = itemsPerPage <= 0 ? ITEMS_PER_PAGE : itemsPerPage;
            boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
            boolean hasStatus = status != null && !status.equals("all");

//            logger.debug("Lấy danh sách combo: page={}, itemsPerPage={}, status={}, keyword={}",
//                    currentPage, itemsPerPageActual, status, keyword);

            // Lấy tổng số items
            long totalItems;
            if (hasKeyword && hasStatus) {
                totalItems = comboService.getTotalCombosByKeywordAndStatus(keyword, status);
            } else if (hasKeyword) {
                totalItems = comboService.getTotalCombosByKeyword(keyword);
            } else if (hasStatus) {
                totalItems = comboService.getComboCountByStatus(status);
            } else {
                totalItems = comboService.getTotalCombos();
            }
            // Tính toán số trang
            int totalPages = Math.max(1, (int) Math.ceil((double) totalItems / itemsPerPageActual));
            if (currentPage > totalPages) {
                currentPage = totalPages;
            }
            // Lấy danh sách combos
            Page<Combo> combos;
            if (hasKeyword && hasStatus) {
                combos = comboService.findByKeywordAndStatus(keyword, status, currentPage, itemsPerPageActual);
            } else if (hasKeyword) {
                combos = comboService.findByKeyword(keyword, currentPage, itemsPerPageActual);
            } else if (hasStatus) {
                combos = comboService.getCombosByPageAndStatus(currentPage, itemsPerPageActual, status);
            } else {
                combos = comboService.getCombosByPage(currentPage, itemsPerPageActual);
            }
            // Lấy message và error từ session
            String message = (String) session.getAttribute("message");
            String error = (String) session.getAttribute("error");
            session.removeAttribute("message");
            session.removeAttribute("error");

            // Thiết lập các thuộc tính cho view
            model.addAttribute("combos", combos);
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalItems", totalItems);
            model.addAttribute("itemsPerPage", itemsPerPageActual);
            model.addAttribute("selectedStatus", status);
            model.addAttribute("keyword", keyword);
            model.addAttribute("message", message);
            model.addAttribute("error", error);
            model.addAttribute("title", "Danh sách combo");

            //logger.debug("Tổng số combo: {}, Số trang: {}, Trang hiện tại: {}", totalItems, totalPages, currentPage);
            return "admin/combos/list";
        } catch (Exception e) {
            //logger.error("Lỗi khi lấy danh sách combo: {}", e.getMessage(), e);
            model.addAttribute("error", "Lỗi khi tải danh sách combo");
            return "admin/combos/list";
        }
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("title", "Thêm combo");
        model.addAttribute("combo", new Combo());
        return "admin/combos/add";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Combo combo = comboService.getComboById(id);
            if (combo == null) {
                logger.warn("Không tìm thấy combo với ID: {}", id);
                redirectAttributes.addFlashAttribute("error", "Combo không tồn tại");
                return "redirect:/admin/combos";
            }
            model.addAttribute("combo", combo);
            model.addAttribute("title", "Chỉnh sửa combo " + combo.getName());
            logger.debug("Hiển thị form chỉnh sửa combo: ID={}", id);
            return "admin/combos/edit";
        } catch (Exception e) {
            logger.error("Lỗi khi lấy combo để chỉnh sửa, ID={}: {}", id, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải thông tin combo");
            return "redirect:/admin/combos";
        }
    }

    @GetMapping("/{id}")
    public String showDetail(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        try {
            Combo combo = comboService.getComboById(id);
            if (combo == null) {
                logger.warn("Không tìm thấy combo với ID: {}", id);
                redirectAttributes.addFlashAttribute("error", "Combo không tồn tại");
                return "redirect:/admin/combos";
            }
            model.addAttribute("combo", combo);
            model.addAttribute("title", "Combo " + combo.getName());
            logger.debug("Hiển thị chi tiết combo: ID={}", id);
            return "admin/combos/detail";
        } catch (Exception e) {
            logger.error("Lỗi khi lấy chi tiết combo, ID={}: {}", id, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Lỗi khi tải chi tiết combo");
            return "redirect:/admin/combos";
        }
    }

    @PostMapping
    public String createCombo(
            @ModelAttribute Combo combo,
            RedirectAttributes redirectAttributes
    ) {
        try {
            comboService.createCombo(combo);
            redirectAttributes.addFlashAttribute("message", "Thêm combo thành công");
            logger.info("Thêm combo thành công: {}", combo.getName());
            return "redirect:/admin/combos";
        } catch (Exception e) {
            logger.error("Lỗi khi thêm combo: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Thêm combo thất bại");
            return "redirect:/admin/combos/add";
        }
    }

    @PostMapping("/{id}")
    public String updateCombo(
            @PathVariable("id") Long id,
            @ModelAttribute Combo combo,
            RedirectAttributes redirectAttributes
    ) {
        try {
            combo.setId(id);
            comboService.updateCombo(combo);
            redirectAttributes.addFlashAttribute("message", "Cập nhật combo thành công");
            logger.info("Cập nhật combo thành công: ID={}", id);
            return "redirect:/admin/combos";
        } catch (Exception e) {
            logger.error("Lỗi khi cập nhật combo, ID={}: {}", id, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Cập nhật combo thất bại");
            return "redirect:/admin/combos/" + id + "/edit";
        }
    }

    @DeleteMapping("/{id}")
    public String deleteCombo(
            @PathVariable("id") Long id,
            RedirectAttributes redirectAttributes
    ) {
        try {
            comboService.deleteCombo(id);
            redirectAttributes.addFlashAttribute("message", "Xóa combo thành công");
            logger.info("Xóa combo thành công: ID={}", id);
            return "redirect:/admin/combos";
        } catch (Exception e) {
            logger.error("Lỗi khi xóa combo, ID={}: {}", id, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("error", "Xóa combo thất bại");
            return "redirect:/admin/combos";
        }
    }
}
