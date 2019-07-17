package com.example.service;
import com.example.model.Menu;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public interface MenuService {
    List<Menu> getAll(String string);
}
