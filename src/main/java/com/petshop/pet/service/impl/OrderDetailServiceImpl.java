package com.petshop.pet.service.impl;

import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.OrderDetail;
import com.petshop.pet.repository.OrderDetailRepository;
import com.petshop.pet.service.OrderDetailService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {

    private final OrderDetailRepository orderDetailRepository;

    public OrderDetailServiceImpl(OrderDetailRepository orderDetailRepository){
        this.orderDetailRepository = orderDetailRepository;
    }

    @Override
    public void saveOrderDetails(Order order, List<CartDetail> cartDetails){
        List<OrderDetail> orderDetails = new ArrayList<>();

        for(CartDetail cd : cartDetails){
            OrderDetail od = new OrderDetail();
            od.setOrder(order);
            od.setProduct(cd.getProduct());
            od.setQuantity(cd.getQuantity());
            od.setPrice(cd.getPrice());
            orderDetails.add(od);
        }

        orderDetailRepository.saveAll(orderDetails);
    }

    @Override
    public List<OrderDetail> getAllByOrder(Order order){
        return orderDetailRepository.findAllByOrder(order);
    }

}
