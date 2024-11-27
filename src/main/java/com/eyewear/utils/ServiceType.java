package com.eyewear.utils;

public enum ServiceType {
    EXAM("Khám mắt"),
    GLASSES("Cắt kính"),
    ADJUSTMENT("Sửa kính"),
    TRY_ON("Thử kính mẫu"),
    MAINTENANCE("Bảo trì kính"),
    ROUTINE_CARE("Chăm sóc mắt định kỳ"),
    COSMETIC("Lắp kính thẩm mỹ"),
    FRAME_CONSULTATION("Tư vấn lựa chọn kính");

    private final String displayName;

    ServiceType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}

