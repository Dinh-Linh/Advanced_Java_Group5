package com.example.advanced_java_group5.controllers.admin;

import com.example.advanced_java_group5.models.entities.User;
import com.example.advanced_java_group5.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    private static final int ITEMS_PER_PAGE = 10;

    @Autowired
    private UserService userService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @GetMapping({"", "/"})
    public String listUsers(Model model,
                            @RequestParam(value = "page", defaultValue = "1") int page,
                            @RequestParam(value = "itemsPerPage", defaultValue = "" + ITEMS_PER_PAGE) int itemsPerPage,
                            @RequestParam(value = "role", required = false) String role,
                            @RequestParam(value = "keyword", required = false) String keyword) {
        Page<User> userPage;
        boolean hasKeyword = keyword != null && !keyword.isEmpty();
        boolean hasRole = role != null && !role.equals("all");

        if (hasKeyword && hasRole) {
            userPage = userService.findByKeywordWithRole(keyword, role, page, itemsPerPage);
        } else if (hasKeyword) {
            userPage = userService.findByKeyword(keyword, page, itemsPerPage);
        } else if (hasRole) {
            userPage = userService.getUsersByRole(page, itemsPerPage, role);
        } else {
            userPage = userService.getUsers(page, itemsPerPage);
        }

        setPaginationAttributes(model, userPage, page, itemsPerPage);
        model.addAttribute("users", userPage.getContent());
        model.addAttribute("selectedRole", role);
        model.addAttribute("keyword", keyword);
        model.addAttribute("title", "Danh sách người dùng");
        return "admin/users/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("title", "Thêm người dùng");
        model.addAttribute("user", new User());
        return "admin/users/add";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Long id, Model model, @ModelAttribute("tempUser") User tempUser) {
        User user = userService.getUserById(id);
        if (user == null) {
            return "redirect:/admin/users?error=User not found";
        }
        model.addAttribute("user", user);
        model.addAttribute("tempUser", tempUser != null ? tempUser : user);
        model.addAttribute("title", "Chỉnh sửa người dùng " + user.getName());
        return "admin/users/edit";
    }

    @GetMapping("/{id}")
    public String showDetail(@PathVariable("id") Long id, Model model) {
        User user = userService.getUserById(id);
        if (user == null) {
            return "redirect:/admin/users?error=User not found";
        }
        model.addAttribute("user", user);
        model.addAttribute("title", "Người dùng " + user.getName());
        return "admin/users/detail";
    }

    @PostMapping
    public String createUser(@ModelAttribute User user,
                             @RequestParam("password") String password,
                             @RequestParam("confirmPassword") String confirmPassword,
                             RedirectAttributes redirectAttributes) {
        if (userService.checkEmailExist(user)) {
            redirectAttributes.addFlashAttribute("error", "Email đã tồn tại");
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/admin/users/add";
        }
        if (userService.checkPhoneExist(user)) {
            redirectAttributes.addFlashAttribute("error", "Số điện thoại đã tồn tại");
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/admin/users/add";
        }
        if (!userService.comparePassword(password, confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu không khớp");
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/admin/users/add";
        }
        try {
            user.setPassword(passwordEncoder.encode(password));
            userService.createUser(user);
            redirectAttributes.addFlashAttribute("message", "Thêm người dùng thành công");
            return "redirect:/admin/users";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/admin/users/add";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Thêm người dùng thất bại");
            redirectAttributes.addFlashAttribute("user", user);
            return "redirect:/admin/users/add";
        }
    }

    @PostMapping("/{id}")
    public String updateUser(@PathVariable("id") Long id,
                             @ModelAttribute User user,
                             @RequestParam(value = "password", required = false) String password,
                             @RequestParam(value = "confirmPassword", required = false) String confirmPassword,
                             RedirectAttributes redirectAttributes) {
        user.setId(id);
        User existingUser = userService.getUserById(id);
        if (existingUser == null) {
            redirectAttributes.addFlashAttribute("error", "Người dùng không tồn tại");
            return "redirect:/admin/users";
        }
        if (userService.checkEmailExist(user)) {
            redirectAttributes.addFlashAttribute("error", "Email đã tồn tại");
            redirectAttributes.addFlashAttribute("tempUser", user);
            return "redirect:/admin/users/" + id + "/edit";
        }
        if (userService.checkPhoneExist(user)) {
            redirectAttributes.addFlashAttribute("error", "Số điện thoại đã tồn tại");
            redirectAttributes.addFlashAttribute("tempUser", user);
            return "redirect:/admin/users/" + id + "/edit";
        }
        if (password != null && !password.trim().isEmpty()) {
            if (!userService.comparePassword(password, confirmPassword)) {
                redirectAttributes.addFlashAttribute("error", "Mật khẩu không khớp");
                redirectAttributes.addFlashAttribute("tempUser", user);
                return "redirect:/admin/users/" + id + "/edit";
            }
            user.setPassword(passwordEncoder.encode(password));
        } else {
            user.setPassword(existingUser.getPassword());
        }
        try {
            userService.updateUser(user);
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth.getName().equals(existingUser.getEmail()) && !existingUser.getEmail().equals(user.getEmail())) {
                redirectAttributes.addFlashAttribute("message", "Cập nhật người dùng thành công. Vui lòng đăng nhập lại.");
                return "redirect:/admin/logout";
            }
            redirectAttributes.addFlashAttribute("message", "Cập nhật người dùng thành công");
            return "redirect:/admin/users";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            redirectAttributes.addFlashAttribute("tempUser", user);
            return "redirect:/admin/users/" + id + "/edit";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Cập nhật người dùng thất bại");
            redirectAttributes.addFlashAttribute("tempUser", user);
            return "redirect:/admin/users/" + id + "/edit";
        }
    }

    @DeleteMapping("/{id}")
    public String deleteUser(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = userService.getUserByEmail(auth.getName());
        if (currentUser != null && currentUser.getId() == id) {
            redirectAttributes.addFlashAttribute("error", "Không thể xóa tài khoản đang đăng nhập");
            return "redirect:/admin/users";
        }
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("message", "Xóa người dùng thành công");
            return "redirect:/admin/users";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Xóa người dùng thất bại");
            return "redirect:/admin/users";
        }
    }

    private void setPaginationAttributes(Model model, Page<?> page, int currentPage, int itemsPerPage) {
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("itemsPerPage", itemsPerPage);
    }
}
