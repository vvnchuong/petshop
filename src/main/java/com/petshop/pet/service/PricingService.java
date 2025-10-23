package com.petshop.pet.service;

import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Voucher;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PricingService {

    public double calculateFinalPrice(List<CartDetail> cartDetails, Voucher voucher){
        double totalPrice = 0;
        for(CartDetail cd : cartDetails)
            totalPrice += cd.getQuantity() * cd.getPrice();

        double finalPrice = totalPrice;
        if(voucher != null){
            double discount;
            if (voucher.getDiscountAmount() == null){
                discount = totalPrice * voucher.getDiscountPercent() * 0.01;
            }else{
                discount = voucher.getDiscountAmount();
            }

            finalPrice = totalPrice - discount;
            if(finalPrice < 0)
                finalPrice = 0;
        }
        return finalPrice;
    }

}
