package com.petshop.pet.domain.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VoucherUsageDTO {

    VoucherDTO voucher;

    AdminCreateUserDTO user;

}
