package com.petshop.pet.domain.dto;

import com.petshop.pet.enums.PaymentMethod;
import com.petshop.pet.enums.Status;
import lombok.*;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CheckoutRequestDTO {

    String receiverName;
    String receiverPhone;
    String receiverAddress;
    Status status = Status.PENDING;
    PaymentMethod paymentMethod;
    String voucherCode;

}
