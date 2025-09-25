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
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    String name;

    @Column(columnDefinition = "MEDIUMTEXT")
    String description;

    @Column(columnDefinition = "MEDIUMTEXT")
    String shortDesc;

    double price;

    int stock;

    String imageUrl;

    Instant createdAt;
    Instant updatedAt;

    String slug;

    @ManyToOne
    @JoinColumn(name = "subcategory_id")
    Subcategory subcategory;

    @ManyToOne
    @JoinColumn(name = "brand_id")
    Brand brand;

}
