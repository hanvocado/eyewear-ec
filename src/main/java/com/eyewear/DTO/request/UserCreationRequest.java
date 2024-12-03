package com.eyewear.DTO.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.validation.constraints.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserCreationRequest {
    @Email(message = "EMAIL_INVALID")
    String email;

    @Size(min = 8, message = "PASSWORD_INVALID")
    String password;
    String phone;
    String firstName;
    String lastName;
}
