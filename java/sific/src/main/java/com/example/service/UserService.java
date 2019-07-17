package com.example.service;

import com.example.model.User;
import org.springframework.stereotype.Service;

@Service
/*用户列表接口*/
public interface UserService {

    /*判断用户是否存在*/
    User UserInfo(String tel);

    //用户登录 返回查询状态
    User login(String tel,String password);

}
