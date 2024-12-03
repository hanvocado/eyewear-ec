package com.eyewear.controllers.buyer;

import com.eyewear.DTO.request.ProfileUpdateRequest;
import com.eyewear.entities.Buyer;
import com.eyewear.services.ProfileService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/buyer")
@RequiredArgsConstructor
public class ProfileController {

    private final ProfileService profileService;

    @GetMapping("/profile")
    public String showProfile(Model model) {
        Buyer buyer = profileService.getCurrentBuyerProfile();
        model.addAttribute("buyer", buyer);
        return "buyer/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(
            @ModelAttribute @Valid ProfileUpdateRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("error",
                    "Invalid information. Please check again.");
            return "redirect:/buyer/profile";
        }

        try {
            profileService.updateProfile(request);
            redirectAttributes.addFlashAttribute("success",
                    "Profile updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error",
                    "An error occurred: " + e.getMessage());
        }

        return "redirect:/buyer/profile";
    }

    @PostMapping("/profile/update-avatar")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateAvatar(
            @RequestParam("picture") MultipartFile picture) {
        Map<String, Object> response = new HashMap<>();

        try {
            // Validate file size
            if (picture.getSize() > 5 * 1024 * 1024) { // 5MB
                throw new IllegalArgumentException(
                        "File size too large! Please select a file under 5MB.");
            }

            // Validate file type
            String contentType = picture.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                throw new IllegalArgumentException(
                        "Invalid file type! Please select an image file.");
            }

            String pictureUrl = profileService.uploadProfilePicture(picture);

            // Update buyer's picture URL
            Buyer buyer = profileService.getCurrentBuyerProfile();
            buyer.setPicture(pictureUrl);
            profileService.saveBuyer(buyer);

            response.put("success", true);
            response.put("message", "Avatar updated successfully!");
            response.put("pictureUrl", pictureUrl);

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}