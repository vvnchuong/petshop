package com.petshop.pet.domain.dto;

import com.petshop.pet.domain.Role;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AdminCreateUserDTO {

    @NotBlank(message = "Full name is required")
    String fullName;

    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    String email;

    @NotBlank(message = "Username is required")
    String username;

    @NotBlank(message = "Phone is required")
    @Pattern(regexp = "^(\\+84|0)[3-9]\\d{8}$", message = "Invalid phone number")
    String phone;

    @NotBlank(message = "Address is required")
    String address;

    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password must be at least 6 characters")
    String password;

    Role role;

    String avatarUrl;

}
