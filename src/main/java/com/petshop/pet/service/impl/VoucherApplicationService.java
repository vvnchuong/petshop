package com.petshop.pet.service.impl;

import com.petshop.pet.config.CustomUserDetails;
import com.petshop.pet.domain.dto.CartDataDTO;
import com.petshop.pet.domain.dto.VoucherResultDTO;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;

@Service
public class VoucherApplicationService {

    private final CartFacadeService cartFacadeService;

    private final VoucherService voucherService;

    public VoucherApplicationService(CartFacadeService cartFacadeService,
                                     VoucherService voucherService){
        this.cartFacadeService = cartFacadeService;
        this.voucherService = voucherService;
    }

    public VoucherResultDTO applyVoucher(String code,
                                         CustomUserDetails currentUser,
                                         HttpSession session){

        CartDataDTO cart = cartFacadeService.getCart(currentUser, session);

        return voucherService.applyVoucher(code, cart.getTotal());
    }

}
