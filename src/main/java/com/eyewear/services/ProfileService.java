package com.eyewear.services;

import com.eyewear.DTO.request.ProfileUpdateRequest;
import com.eyewear.entities.Buyer;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface ProfileService {
    Buyer getCurrentBuyerProfile();
    void updateProfile(ProfileUpdateRequest request);
    String uploadProfilePicture(MultipartFile file) throws IOException;
    void saveBuyer(Buyer buyer);
}