package com.petshop.pet.domain.dto;

import com.petshop.pet.domain.News;
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
public class SendCommentDTO {

    @NotBlank(message = "name is required")
    String name;

    @NotBlank(message = "email is required")
    String email;

    @NotBlank(message = "content is required")
    String content;

    News news;

}
