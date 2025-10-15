package com.petshop.pet.domain.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserUpdateDTO {

    @NotBlank(message = "Full name is required")
    String fullName;

    @NotBlank(message = "Phone number is required")
    String phone;

    @NotBlank(message = "Address is required")
    String address;

    String email;

    String avatarUrl;

}
