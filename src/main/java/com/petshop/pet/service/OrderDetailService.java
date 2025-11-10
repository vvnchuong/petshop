package com.petshop.pet.service;

import com.petshop.pet.domain.CartDetail;
import com.petshop.pet.domain.Order;
import com.petshop.pet.domain.OrderDetail;
import com.petshop.pet.repository.OrderDetailRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class OrderDetailService {

    private final OrderDetailRepository orderDetailRepository;

    public OrderDetailService(OrderDetailRepository orderDetailRepository){
        this.orderDetailRepository = orderDetailRepository;
    }

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

    public List<OrderDetail> getAllByOrder(Order order){
        return orderDetailRepository.findAllByOrder(order);
    }

}
