package com.petshop.pet.service;

import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.OrderDetail;

import java.util.List;

public interface OrderDetailService {

    void saveOrderDetails(Order order, List<CartDetail> cartDetails);

    List<OrderDetail> getAllByOrder(Order order);

}
