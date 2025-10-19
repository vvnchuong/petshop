package com.petshop.pet.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "vouchers")
public class Voucher {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    String code;

    String description;

    @Column(nullable = true)
    Double discountPercent;

    @Column(nullable = true)
    Double discountAmount;

    LocalDateTime startDate;

    LocalDateTime endDate;

    Integer maxUsage; // so luong toi da

    Integer usedCount; // so luong da su dung

    Double minOrder; // gia tri toi thieu

    boolean active;

    @OneToMany(mappedBy = "voucher")
    List<VoucherUsage> voucherUsages = new ArrayList<>();

}
