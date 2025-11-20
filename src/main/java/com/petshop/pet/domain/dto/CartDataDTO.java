package com.petshop.pet.domain.dto;

import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.User;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CartDataDTO {

    private List<CartDetail> cartDetails;
    private double total;
    private User user;

}
