package com.petshop.pet.enums;

public enum Status {

    PENDING("Chờ xử lý"),
    SHIPPING("Đang giao"),
    DELIVERED("Đã giao"),
    CANCELLED("Đã hủy"),
    FAILED("Thanh toán không thành công");

    private final String name;

    Status(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

}
