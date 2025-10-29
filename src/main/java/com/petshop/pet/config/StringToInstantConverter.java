package com.petshop.pet.config;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Component
public class StringToInstantConverter implements Converter<String, Instant> {

    private static final DateTimeFormatter F =
            DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    private static final ZoneId VN = ZoneId.of("Asia/Ho_Chi_Minh");

    @Override
    public Instant convert(String source) {
        if (source == null || source.isBlank()) return null;
        LocalDateTime ldt = LocalDateTime.parse(source, F);
        return ldt.atZone(VN).toInstant();
    }
}
