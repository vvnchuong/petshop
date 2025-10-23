package com.petshop.pet.service;

import com.petshop.pet.domain.Voucher;
import com.petshop.pet.domain.dto.VoucherDTO;
import com.petshop.pet.domain.dto.VoucherUpdateDTO;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.mapper.VoucherMapper;
import com.petshop.pet.repository.VoucherRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

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

}
