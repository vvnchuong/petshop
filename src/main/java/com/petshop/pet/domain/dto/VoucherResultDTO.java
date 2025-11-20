package com.petshop.pet.domain.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VoucherResultDTO {

    boolean success;
    String message;
    Double discount;
    Double finalPrice;

    public static VoucherResultDTO ok(Double discount, Double finalPrice){
        return VoucherResultDTO.builder()
                .success(true)
                .discount(discount)
                .finalPrice(finalPrice)
                .build();
    }

    public static VoucherResultDTO error(String message){
        return VoucherResultDTO.builder()
                .success(false)
                .message(message)
                .build();
    }

}
