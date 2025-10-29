package com.petshop.pet.domain.dto;

import jakarta.validation.constraints.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.Instant;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VoucherUpdateDTO {

    @NotBlank(message = "Code is required")
    @Size(min = 6, message = "Code must be at least 6 characters")
    String code;

    @NotBlank(message = "Description is required")
    @Size(max = 255, message = "Description should not exceed 255 characters")
    String description;

    Double discountPercent;

    @DecimalMin(value = "0.0", inclusive = false, message = "Discount amount must be greater than 0")
    Double discountAmount;

    @NotNull(message = "Start date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    Instant startDate;

    @NotNull(message = "End date is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    Instant endDate;

    @Min(value = 1, message = "Max usage must be at least 1")
    Integer maxUsage;

    Integer usedCount;

    @DecimalMin(value = "0.0", inclusive = true, message = "Min order value must be at least 0")
    Double minOrder;

    boolean active;

    List<VoucherUsageDTO> voucherUsages;

}
