package com.eyewear.services.impl;

import com.eyewear.DTO.request.ProfileUpdateRequest;
import com.eyewear.entities.Address;
import com.eyewear.entities.Buyer;
import com.eyewear.repositories.BuyerRepository;
import com.eyewear.services.ProfileService;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ProfileServiceImpl implements ProfileService {

    private final BuyerRepository buyerRepository;
    private final Cloudinary cloudinary;

    @Override
    public Buyer getCurrentBuyerProfile() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        return buyerRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

    @Override
    public void updateProfile(ProfileUpdateRequest request) {
        Buyer buyer = getCurrentBuyerProfile();

        // Update basic fields
        if (request.getFirstName() != null) {
            buyer.setFirstName(request.getFirstName());
        }
        if (request.getLastName() != null) {
            buyer.setLastName(request.getLastName());
        }
        if (request.getPhone() != null) {
            buyer.setPhone(request.getPhone());
        }

        // Update address
        Address address = buyer.getAddress();
        if (address == null) {
            address = new Address();
        }

        // Update address fields if provided
        if (request.getProvince() != null && !request.getProvince().isEmpty()) {
            address.setProvince(request.getProvince());
        }
        if (request.getDistrict() != null && !request.getDistrict().isEmpty()) {
            address.setDistrict(request.getDistrict());
        }
        if (request.getCommue() != null && !request.getCommue().isEmpty()) {
            address.setCommue(request.getCommue());
        }
        if (request.getStreetName() != null && !request.getStreetName().isEmpty()) {
            address.setStreetName(request.getStreetName());
        }
        if (request.getStreetNumber() != null) {
            address.setStreetNumber(request.getStreetNumber());
        }

        // Set updated address back to buyer
        buyer.setAddress(address);

        // Save buyer with updated information
        buyerRepository.save(buyer);
    }

    @Override
    public String uploadProfilePicture(MultipartFile file) throws IOException {
        Map uploadResult = cloudinary.uploader().upload(
                file.getBytes(),
                ObjectUtils.asMap(
                        "folder", "profile-pictures",
                        "resource_type", "auto"));
        return uploadResult.get("secure_url").toString();
    }

    @Override
    public void saveBuyer(Buyer buyer) {
        buyerRepository.save(buyer);
    }
}