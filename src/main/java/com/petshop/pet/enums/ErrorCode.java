package com.petshop.pet.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

@Getter
@AllArgsConstructor
public enum ErrorCode {

    // User-related errors
    USER_ALREADY_EXISTS(1001, "User already exists", HttpStatus.BAD_REQUEST),
    USER_NOT_FOUND(1002, "User not found", HttpStatus.NOT_FOUND),
    EMAIL_ALREADY_EXISTS(1003, "Email already exists", HttpStatus.BAD_REQUEST),
    PASSWORD_MISMATCH(1004, "Password and confirm password do not match", HttpStatus.BAD_REQUEST),
    OLD_PASSWORD_INCORRECT(1005, "Old password is incorrect", HttpStatus.BAD_REQUEST),
    NEW_PASSWORD_MISMATCH(1006, "New password and confirmation do not match", HttpStatus.BAD_REQUEST),

    // Product-related errors
    PRODUCT_ALREADY_ORDERED(2001, "Product already ordered", HttpStatus.BAD_REQUEST),
    PRODUCT_NOT_FOUND(2002, "Product not found", HttpStatus.NOT_FOUND),
    PRODUCT_ALREADY_EXISTS(2003, "Slug already exists", HttpStatus.BAD_REQUEST),

    // Order-related errors
    STOCK_QUANTITY_INVALID(3001, "Stock must be greater than 0", HttpStatus.BAD_REQUEST),
    ORDER_NOT_FOUND(3002, "Order not found", HttpStatus.NOT_FOUND),

    // Cart-related errors
    CART_NOT_FOUND(4001, "Cart not found", HttpStatus.NOT_FOUND),

    // PetType-related errors
    PETTYPE_NOT_FOUND(5001, "Pet type not found", HttpStatus.NOT_FOUND),

    // Voucher-related errors
    VOUCHER_ALREADY_EXISTS(6001, "Voucher already exists", HttpStatus.BAD_REQUEST),
    VOUCHER_NOT_FOUND(6002, "Voucher not found", HttpStatus.NOT_FOUND),

    // New-related errors
    NEWS_ALREADY_EXISTS(7001, "News already exists", HttpStatus.BAD_REQUEST),
    NEWS_NOT_FOUND(7002, "News not found", HttpStatus.NOT_FOUND),

    // File-related errors
    IMAGE_NOT_SELECTED(8001, "Please choose an image to upload", HttpStatus.BAD_REQUEST),
    INVALID_IMAGE_FORMAT(8002, "Only JPG, JPEG, and PNG image formats are allowed", HttpStatus.BAD_REQUEST),
    IMAGE_UPLOAD_FAILED(8003, "Image upload failed", HttpStatus.INTERNAL_SERVER_ERROR),

    // Token-related errors
    TOKEN_INVALID(9001, "Reset token is invalid", HttpStatus.BAD_REQUEST),
    TOKEN_EXPIRED(9002, "Reset token has expired", HttpStatus.BAD_REQUEST),

    // Brand-related errors
    BRAND_ALREADY_EXISTS(10001, "Brand already exists", HttpStatus.BAD_REQUEST),
    BRAND_NOT_FOUND(10002, "Brand not found", HttpStatus.NOT_FOUND),

    // email error code
//    EMAIL_SEND_FAILED(9003, "Failed to send email", HttpStatus.INTERNAL_SERVER_ERROR)
    ;

    private int code;
    private String message;
    private HttpStatusCode httpStatusCode;

}
