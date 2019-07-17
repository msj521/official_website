package com.example.service.impl;

import com.example.mapper.Menu.MenuMapper;
import com.example.model.Menu;
import com.example.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuMapper menuMapper;

    //导航栏列表 userMapper
    @Override
    public List<Menu> getAll(String string) {
        return menuMapper.findAll(string);
    }

}
