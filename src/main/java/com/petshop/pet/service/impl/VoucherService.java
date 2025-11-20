package com.petshop.pet.service.impl;

import com.petshop.pet.domain.Voucher;
import com.petshop.pet.domain.dto.VoucherDTO;
import com.petshop.pet.domain.dto.VoucherResultDTO;
import com.petshop.pet.domain.dto.VoucherUpdateDTO;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.mapper.VoucherMapper;
import com.petshop.pet.repository.VoucherRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class VoucherService {

    private final VoucherRepository voucherRepository;

    private final VoucherMapper voucherMapper;

    public VoucherService(VoucherRepository voucherRepository,
                          VoucherMapper voucherMapper){
        this.voucherRepository = voucherRepository;
        this.voucherMapper = voucherMapper;
    }

    public Page<Voucher> getAllVouchers(Specification<Voucher> spec,
                                        Pageable page){
        return voucherRepository.findAll(spec, page);
    }

    public Voucher getVoucherById(long voucherId){
        return voucherRepository.findById(voucherId)
                .orElseThrow(() -> new BusinessException(ErrorCode.VOUCHER_NOT_FOUND));
    }

    public void createVoucher(VoucherDTO voucherDTO){
        if(voucherRepository.findByCode(voucherDTO.getCode()).isPresent()){
            throw new BusinessException(ErrorCode.VOUCHER_ALREADY_EXISTS);
        }else{
            Voucher voucher = voucherMapper.toVoucher(voucherDTO);
            voucher.setUsedCount(0);
            voucherRepository.save(voucher);
        }
    }

    public void updateVoucher(long voucherId , VoucherUpdateDTO voucherUpdateDTO){
        Voucher voucher = voucherRepository.findById(voucherId)
                .orElseThrow(() -> new BusinessException(ErrorCode.VOUCHER_NOT_FOUND));

        voucherMapper.updateVoucher(voucher, voucherUpdateDTO);

        voucherRepository.save(voucher);
    }

    public void deleteVoucher(long voucherId){
        voucherRepository.findById(voucherId)
                .orElseThrow(() -> new BusinessException(ErrorCode.VOUCHER_NOT_FOUND));

        voucherRepository.deleteById(voucherId);
    }

    public Voucher getVoucherByCode(String code){
        return voucherRepository.findByCode(code)
                .orElseThrow(() -> new BusinessException(ErrorCode.VOUCHER_NOT_FOUND));
    }

    public Voucher checkVoucher(String code){
        if(code == null || code.isEmpty())
            return null;

        return getVoucherByCode(code);
    }

    public void increaseUsedCount(Voucher voucher){
        if(voucher == null)
            return;

        voucher.setUsedCount(voucher.getUsedCount() + 1);
        voucherRepository.save(voucher);
    }

    public VoucherResultDTO applyVoucher(String code, double total){
        Voucher v = getVoucherByCode(code);

        if(v == null || !v.isActive())
            return VoucherResultDTO.error("Voucher không tồn tại");

        if(v.getUsedCount() >= v.getMaxUsage())
            return VoucherResultDTO.error("Số lượng sử dụng đã đạt giới hạn");

        if(v.getMinOrder() > total)
            return VoucherResultDTO.error("Giá trị đơn hàng phải lớn hơn " + v.getMinOrder());

        if(v.getEndDate().isBefore(Instant.now()))
            return VoucherResultDTO.error("Voucher đã hết hạn");

        double discount = v.getDiscountAmount() != null
                ? v.getDiscountAmount()
                : total * v.getDiscountPercent() / 100;

        double finalPrice = Math.max(total - discount, 0);

        return VoucherResultDTO.ok(discount, finalPrice);
    }

}
