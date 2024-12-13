package com.eyewear.controllers.admin;

import com.eyewear.DTO.request.UserCreationRequest;
import com.eyewear.DTO.request.UserUpdateRequest;
import com.eyewear.entities.Buyer;
import com.eyewear.entities.Manager;
import com.eyewear.repositories.BranchRepository;
import com.eyewear.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin/accounts")
public class AccountController {

    @Autowired
    private UserService userService;

    @Autowired
    private BranchRepository branchRepository;

    // Manager endpoints
    @GetMapping("/managers")
    public String listManagers(Model model) {
        try {
            model.addAttribute("managers", userService.findAllManagers());
            return "admin/manager-list";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải danh sách manager: " + e.getMessage());
            return "admin/manager-list";
        }
    }

    @GetMapping("/managers/add")
    public String showAddManagerForm(Model model) {
        if (!model.containsAttribute("manager")) {
            model.addAttribute("manager", new UserCreationRequest());
        }
        model.addAttribute("branches", branchRepository.findAll());
        return "admin/manager-form";
    }

    @PostMapping("/managers/save")
    public String saveManager(@Valid @ModelAttribute("manager") UserCreationRequest request,
                              BindingResult result,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        if (result.hasErrors() || !request.getPassword().equals(request.getConfirmPassword())) {
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp");
            return "admin/manager-form";
        }

        // Phone validation - Check if phone is provided and has at least 9 digits
        if (request.getPhone() != null && request.getPhone().length() < 9) {
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("error", "Số điện thoại phải có ít nhất 9 chữ số");
            return "admin/manager-form";
        }

        if (userService.emailExists(request.getEmail())) {
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("error", "Email đã tồn tại");
            return "admin/manager-form";
        }

        try {
            userService.createManager(request);
            redirectAttributes.addFlashAttribute("success", "Thêm manager thành công");
            return "redirect:/admin/accounts/managers";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("branches", branchRepository.findAll());
            return "admin/manager-form";
        }
    }


    @PostMapping("/managers/edit/{id}")
    public String updateManager(@PathVariable String id,
                                @Valid @ModelAttribute("manager") UserUpdateRequest request,
                                BindingResult result,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        if (result.hasErrors() || !request.getPassword().equals(request.getConfirmPassword())) {
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp");
            return "admin/manager-form";
        }

        // Phone validation - Check if phone is provided and has at least 9 digits
        if (request.getPhone() != null && !request.getPhone().isEmpty() && request.getPhone().length() < 9) {
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("error", "Số điện thoại phải có ít nhất 9 chữ số");
            return "admin/manager-form";
        }


        // Email validation for existing manager
        Manager existingManager = (Manager) userService.getUser(id);
        if (!existingManager.getEmail().equals(request.getEmail()) && userService.emailExists(request.getEmail())) {
            model.addAttribute("branches", branchRepository.findAll());
            model.addAttribute("error", "Email đã tồn tại");
            return "admin/manager-form";
        }

        try {
            userService.updateManager(id, request);
            redirectAttributes.addFlashAttribute("success", "Cập nhật manager thành công");
            return "redirect:/admin/accounts/managers";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("branches", branchRepository.findAll());
            return "admin/manager-form";
        }
    }


    @GetMapping("/managers/edit/{id}")
    public String showEditManagerForm(@PathVariable String id, Model model) {
        try {
            Manager manager = (Manager) userService.getUser(id);
            UserUpdateRequest updateRequest = new UserUpdateRequest();
            updateRequest.setEmail(manager.getEmail());
            updateRequest.setFirstName(manager.getFirstName());
            updateRequest.setLastName(manager.getLastName());
            updateRequest.setPhone(manager.getPhone());
            if (manager.getBranch() != null) {
                updateRequest.setBranchId(manager.getBranch().getId());
            }

            model.addAttribute("manager", updateRequest);
            model.addAttribute("branches", branchRepository.findAll());
            return "admin/manager-form";
        } catch (Exception e) {
            model.addAttribute("error", "Không tìm thấy manager");
            return "redirect:/admin/accounts/managers";
        }
    }

    @GetMapping("/managers/delete/{id}")
    public String deleteManager(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteManager(id);
            redirectAttributes.addFlashAttribute("success", "Xóa manager thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa manager: " + e.getMessage());
        }
        return "redirect:/admin/accounts/managers";
    }

    // Buyer endpoints
    @GetMapping("/buyers")
    public String listBuyers(Model model) {
        try {
            model.addAttribute("buyers", userService.findAllBuyers());
            return "admin/buyer-list";
        } catch (Exception e) {
            model.addAttribute("error", "Lỗi khi tải danh sách buyer: " + e.getMessage());
            return "admin/buyer-list";
        }
    }

    @GetMapping("/buyers/add")
    public String showAddBuyerForm(Model model) {
        if (!model.containsAttribute("buyer")) {
            model.addAttribute("buyer", new UserCreationRequest());
        }
        return "admin/buyer-form";
    }

    @PostMapping("/buyers/save")
    public String saveBuyer(@Valid @ModelAttribute("buyer") UserCreationRequest request,
                            BindingResult result,
                            Model model,
                            RedirectAttributes redirectAttributes) {
        if (result.hasErrors() || !request.getPassword().equals(request.getConfirmPassword())) {
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp");
            return "admin/buyer-form";
        }

        if (userService.emailExists(request.getEmail())) {
            model.addAttribute("error", "Email đã tồn tại");
            return "admin/buyer-form";
        }

        if (request.getPhone().length() < 10) {
            model.addAttribute("error", "Số điện thoại phải có ít nhất 10 chữ số");
            return "admin/buyer-form";
        }

        try {
            userService.createBuyer(request);
            redirectAttributes.addFlashAttribute("success", "Thêm buyer thành công");
            return "redirect:/admin/accounts/buyers";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "admin/buyer-form";
        }
    }

    @GetMapping("/buyers/edit/{id}")
    public String showEditBuyerForm(@PathVariable String id, Model model) {
        try {
            Buyer buyer = userService.getBuyer(id);
            UserUpdateRequest request = new UserUpdateRequest();
            request.setEmail(buyer.getEmail());
            request.setFirstName(buyer.getFirstName());
            request.setLastName(buyer.getLastName());
            request.setPhone(buyer.getPhone());
            if (buyer.getAddress() != null) {
                request.setStreetNumber(String.valueOf(buyer.getAddress().getStreetNumber()));
                request.setStreetName(buyer.getAddress().getStreetName());
                request.setCommue(buyer.getAddress().getCommue());
                request.setDistrict(buyer.getAddress().getDistrict());
                request.setProvince(buyer.getAddress().getProvince());
            }

            model.addAttribute("buyer", request);
            return "admin/buyer-form";
        } catch (Exception e) {
            model.addAttribute("error", "Không tìm thấy buyer");
            return "redirect:/admin/accounts/buyers";
        }
    }

    @PostMapping("/buyers/edit/{id}")
    public String updateBuyer(@PathVariable String id,
                              @Valid @ModelAttribute("buyer") UserUpdateRequest request,
                              BindingResult result,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        if (result.hasErrors() || !request.getPassword().equals(request.getConfirmPassword())) {
            model.addAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp");
            return "admin/buyer-form";
        }

        if (userService.emailExists(request.getEmail())) {
            model.addAttribute("error", "Email đã tồn tại");
            return "admin/buyer-form";
        }

        if (request.getPhone().length() < 10) {
            model.addAttribute("error", "Số điện thoại phải có ít nhất 10 chữ số");
            return "admin/buyer-form";
        }

        try {
            userService.updateBuyer(id, request);
            redirectAttributes.addFlashAttribute("success", "Cập nhật buyer thành công");
            return "redirect:/admin/accounts/buyers";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "admin/buyer-form";
        }
    }

    @GetMapping("/buyers/delete/{id}")
    public String deleteBuyer(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            userService.deleteBuyer(id);
            redirectAttributes.addFlashAttribute("success", "Xóa buyer thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa buyer: " + e.getMessage());
        }
        return "redirect:/admin/accounts/buyers";
    }
}