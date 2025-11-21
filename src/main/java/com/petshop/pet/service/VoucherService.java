package com.petshop.pet.service;

import com.petshop.pet.domain.Voucher;
import com.petshop.pet.domain.dto.VoucherDTO;
import com.petshop.pet.domain.dto.VoucherResultDTO;
import com.petshop.pet.domain.dto.VoucherUpdateDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

public interface VoucherService {

    Page<Voucher> getAllVouchers(Specification<Voucher> spec, Pageable page);

    Voucher getVoucherById(long voucherId);

    void createVoucher(VoucherDTO voucherDTO);

    void updateVoucher(long voucherId, VoucherUpdateDTO voucherUpdateDTO);

    void deleteVoucher(long voucherId);

    Voucher getVoucherByCode(String code);

    Voucher checkVoucher(String code);

    void increaseUsedCount(Voucher voucher);

    VoucherResultDTO applyVoucher(String code, double total);

}
