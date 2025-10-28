package com.petshop.pet.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.Instant;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "news")
public class News {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    long id;

    String title;
    String slug;
    @Column(columnDefinition = "TEXT")
    String content;

    String thumbnail;

    Instant createdAt;
    Instant updatedAt;

    @ManyToOne
    @JoinColumn(name = "user_id")
    User user;

}
