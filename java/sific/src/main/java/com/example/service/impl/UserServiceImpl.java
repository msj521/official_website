package com.example.service.impl;

import com.example.mapper.Admin.AdminMapper;
import com.example.model.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class UserServiceImpl implements UserService {

    @Autowired
    public AdminMapper adminMapper;

    @Override
    public User UserInfo(String tel) {
        return adminMapper.user_info(tel);
    }

    @Override
    public User login(String tel, String password) {
        return adminMapper.login(tel,password);
    }
}
