package com.eyewear.DTO.request;

import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserUpdateRequest {
    private String email;
    private String password;
    private String confirmPassword;
    private String firstName;
    private String lastName;
    private String phone;
    private String picture;
    
    // Address fields for Buyer
    private String streetNumber;
    private String streetName;
    private String commue;
    private String district;
    private String province;
    
    // Branch field for Manager
    private Long branchId;
}