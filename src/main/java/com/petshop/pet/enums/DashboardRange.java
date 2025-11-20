package com.petshop.pet.enums;

import lombok.Getter;

import java.time.*;
import java.time.temporal.TemporalAdjusters;

@Getter
public enum DashboardRange {
    TODAY("Hôm nay"),
    YESTERDAY("Hôm qua"),
    DAYS_7("7 ngày qua"),
    DAYS_30("30 ngày qua"),
    THIS_MONTH("Tháng này");

    private final String label;
    private static final ZoneId ZONE_ID = ZoneId.of("Asia/Ho_Chi_Minh");

    DashboardRange(String label) {
        this.label = label;
    }

    public record TimeFrame(Instant start, Instant end) {}

    public TimeFrame calculateTimeFrame() {
        LocalDate today = LocalDate.now(ZONE_ID);
        Instant start;
        Instant end = LocalDateTime.of(today, LocalTime.MAX).atZone(ZONE_ID).toInstant();

        switch (this) {
            case YESTERDAY -> {
                start = today.minusDays(1).atStartOfDay(ZONE_ID).toInstant();
                end = today.minusDays(1).atTime(LocalTime.MAX).atZone(ZONE_ID).toInstant();
            }
            case DAYS_7 -> start = today.minusDays(6).atStartOfDay(ZONE_ID).toInstant();
            case DAYS_30 -> start = today.minusDays(29).atStartOfDay(ZONE_ID).toInstant();
            case THIS_MONTH -> start = today.with(TemporalAdjusters.firstDayOfMonth()).atStartOfDay(ZONE_ID).toInstant();
            case TODAY -> start = today.atStartOfDay(ZONE_ID).toInstant(); // Default
            default -> start = today.atStartOfDay(ZONE_ID).toInstant();
        }
        return new TimeFrame(start, end);
    }
}