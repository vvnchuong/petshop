package com.petshop.pet.mapper;

import com.petshop.pet.domain.Voucher;
import com.petshop.pet.domain.dto.VoucherDTO;
import com.petshop.pet.domain.dto.VoucherUpdateDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface VoucherMapper {

    @Mapping(source = "voucherUsages", target = "voucherUsages")
    VoucherDTO toVoucherDTO(Voucher voucher);

    @Mapping(source = "voucherUsages", target = "voucherUsages")
    Voucher toVoucher(VoucherDTO voucherDTO);

    @Mapping(target = "usedCount", ignore = true)
    void updateVoucher(@MappingTarget Voucher voucher, VoucherUpdateDTO voucherUpdateDTO);

}
