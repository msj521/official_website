package com.example.demo.admin;

import com.example.mapper.Admin.AdminMapper;
import com.example.model.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
public class LoginController {

    @Autowired
    public AdminMapper adminMapper;

    //用户登录页面
    @RequestMapping("/admin")
    public String admin(Model model){
        model.addAttribute("title","登录");
        return "redirect:/login";
    }

    //用户登录页面
    @RequestMapping("/login")
    public String login(Model model){
        model.addAttribute("title","登录");
        return "/admin/index/login";
    }

    /*逻辑实现*/
    @ResponseBody
    @PostMapping("/loginVerify")
    public Map<String, Object> loginVerify(User user,HttpSession session){
        Map<String, Object> map = new HashMap<>();
        if(user.getTel()==null){
            map.put("code", "401");
            map.put("msg", "请输入手机号！");
        }else if(user.getPassword()==null){
            map.put("code", "402");
            map.put("msg", "请输入密码！");
        }else if(session.getAttribute("tel")!=null){
            map.put("code", "403");
            map.put("msg", "请勿重复登录！");
        }else {
            User verify = adminMapper.user_info(user.getTel());
            if(verify!=null){
                //对密码进行 md5 加密
                String Password = DigestUtils.md5DigestAsHex(user.getPassword().getBytes());
                if(verify.getPassword().equals(Password)){
                    session.setAttribute("tel",user.getTel());
                    session.setAttribute("user_name",verify.getUser_name());
                    session.setMaxInactiveInterval(2*60);//以秒为单位，即在没有活动30分钟后，session将失效
                    map.put("code", "200");
                    map.put("msg", "登陆成功");
                }else {
                    map.put("code", "403");
                    map.put("msg", "用户密码错误！");
                }
            }else {
                map.put("code", "404");
                map.put("msg", "用户不存在！");
            }
        }
        return map;
    }

    //退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("tel");
        return "redirect:/admin";
    }

}
