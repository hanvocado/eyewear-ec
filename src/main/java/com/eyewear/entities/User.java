package com.eyewear.entities;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;




@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;
    String email;
    String password;
    String phone;
    String firstName;
    String lastName;
    String address;
    String roles;
    String picture;
    Long branchId;
}