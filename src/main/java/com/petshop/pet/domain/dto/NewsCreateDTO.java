package com.petshop.pet.domain.dto;

import com.petshop.pet.domain.User;
import jakarta.validation.constraints.NotBlank;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NewsCreateDTO {

    @NotBlank(message = "title is required")
    String title;

    @NotBlank(message = "Content is required")
    String content;

    String thumbnail;

    User user;

}
