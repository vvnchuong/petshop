package com.petshop.pet.domain;

import com.petshop.pet.enums.PaymentMethod;
import com.petshop.pet.enums.Status;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    @Column(unique = true, nullable = false, updatable = false)
    String orderCode;

    double totalAmount;

    String receiverName;

    String receiverPhone;

    Instant createdAt;
    Instant updatedAt;

    @Enumerated(EnumType.STRING)
    Status status;

    @Enumerated(EnumType.STRING)
    PaymentMethod paymentMethod;

    String shippingAddress;

    String responseCode;
    String transactionCode;

    String sessionId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;

    @OneToMany(mappedBy = "order")
    List<OrderDetail> orderDetails = new ArrayList<>();

}
