package com.petshop.pet.utils;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

public class PageableUtil {
    public static Pageable createPageable(int page, int size, String sort) {
        switch (sort) {
            case "priceAsc":
                return PageRequest.of(page, size, Sort.by("price").ascending());
            case "priceDesc":
                return PageRequest.of(page, size, Sort.by("price").descending());
            default:
                return PageRequest.of(page, size);
        }
    }
}
