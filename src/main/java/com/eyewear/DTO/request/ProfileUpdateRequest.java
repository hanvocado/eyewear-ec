package com.eyewear.DTO.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ProfileUpdateRequest {
    @NotBlank(message = "First name is required")
    private String firstName;

    @NotBlank(message = "Last name is required")
    private String lastName;

    @NotBlank(message = "Phone number is required")
    @Size(min = 9, message = "Phone number must be at least 9 digits")
    private String phone;

    // Address fields
    private String province;
    private String district;
    private String commue;
    private String streetName;
    private Integer streetNumber;
}