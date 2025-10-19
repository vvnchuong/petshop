package com.petshop.pet.repository;

import com.petshop.pet.domain.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

public interface VoucherRepository extends JpaRepository<Voucher, Long>,
        JpaSpecificationExecutor<Voucher> {

    Optional<Voucher> findByCode(String code);

}
