package com.petshop.pet.service.impl;

import com.petshop.pet.domain.OrderDetail;
import com.petshop.pet.domain.Product;
import com.petshop.pet.enums.ErrorCode;
import com.petshop.pet.exception.BusinessException;
import com.petshop.pet.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class StockService {

    private final ProductRepository productRepository;

    public StockService(ProductRepository productRepository){
        this.productRepository = productRepository;
    }

    @Transactional
    public void reserveStock(List<OrderDetail> orderDetails){
        if (orderDetails == null || orderDetails.isEmpty())
            return;

        List<Long> productIds = orderDetails.stream()
                .map(od -> od.getProduct().getId())
                .distinct()
                .collect(Collectors.toList());

        List<Product> products = productRepository.findByIdIn(productIds);

        Map<Long, Product> productById = products.stream()
                .collect(Collectors.toMap(Product::getId, p -> p));

        List<Product> toSave = new ArrayList<>();
        for(OrderDetail od : orderDetails){
            Long pid = od.getProduct().getId();
            Product p = productById.get(pid);

            if(p == null)
                throw new BusinessException(ErrorCode.STOCK_QUANTITY_INVALID);

            int remaining = p.getStock() - od.getQuantity();
            if(remaining < 0)
                throw new BusinessException(ErrorCode.STOCK_QUANTITY_INVALID);

            p.setStock(remaining);
            toSave.add(p);
        }

        if(!toSave.isEmpty())
            productRepository.saveAll(toSave);
    }

}
