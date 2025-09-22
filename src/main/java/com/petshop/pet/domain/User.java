package com.petshop.pet.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.time.Instant;

@Entity
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    String username;

    String password;

    String email;

    String fullName;

    String phone;

    String address;

    Instant createdAt;
    Instant updatedAt;

    @ManyToOne
    @JoinColumn(name = "role_id")
    Role role;

}
