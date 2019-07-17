package com.example.enums;

public enum StatusEnum {
    LOGIN_FAIL(-1, "登录失败, 登录信息不正确"),
    LOGOUT_SUCCESS(-2, "登出成功");
    private Integer code; private String message;

    StatusEnum(Integer code, String message) {
        this.code = code; this.message = message;
    }
}
