package com.eyewear.exceptions;

import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;

@FieldDefaults(level = AccessLevel.PRIVATE)

public enum ErrorCode {
   // UNCATEGORIZED_EXCEPTION(9999, "Lỗi gì đó bạn không biết, tôi cũng không :Đ."),
    INVALID_KEY(1000, "Lỗi khai báo sai Message Key."),
    EMAIL_EXISTED(1001, "Email đã được đăng ký trước đó, vui lòng nhập Email khác."),
    EMAIL_INVALID(1002, "Vui lòng nhập đúng email!"),
    PASSWORD_INVALID(1003, "Mật khẩu phải chứa ít nhất 8 kí tự!"),
    USER_NOT_EXISTED(1004, "Email đăng nhập không tồn tại hoặc không đúng!"),
    UNAUTHENTICATED(1004, "Sai email hoặc mật khẩu!")

            ;

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    int code;
    String message;

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
