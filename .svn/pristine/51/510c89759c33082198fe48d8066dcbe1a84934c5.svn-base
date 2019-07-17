package com.example.demo.admin;

import com.example.config.Layui;
import com.example.mapper.Admin.AdminMapper;
import com.example.mapper.Api.ApiMapper;
import com.example.model.Menu;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
@Controller
@RequestMapping("/menu")
public class MenuController extends CommonController{

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private ApiMapper apiMapper;


    /**
     * 首页
     * @param model 模型
     * @return 返回视图
     */
    @RequestMapping("/index")
    public String Menu(Model model) {
        model.addAttribute("title","菜单列表");
        return "/admin/menu/index";
    }

    /**
     * 导航栏 分页查询
     * @param string 搜索内容
     * @param page   当前页
     * @param size 几条
     * @return 返回数据结构
     */
    @GetMapping("/list")
    @ResponseBody
    public Layui list(@RequestParam(value = "string",required = false,defaultValue = "") String string,
       @RequestParam(value = "page",required = false,defaultValue = "1") int page,
       @RequestParam(value = "limit",required = false,defaultValue = "1") int size) {
        PageHelper.startPage(page,size,"fid desc");
        //3. 因为PageHelper的作用，这里就会返回当前分页的集合了
        List<Menu> cs =  adminMapper.menu_list(string.trim());
        //4. 根据返回的集合，创建PageInfo对象
        PageInfo<Menu> list = new PageInfo<>(cs);
        return Layui.data((int) list.getTotal(), list.getList());
    }

    /**
     * 导航栏编辑
     * @param model 模型
     * @param fid 主键id
     * @return 返回一条数据
     */
    @GetMapping("/edit")
    public String Edit(Model model,@RequestParam(value = "fid",required = false) Integer fid) {
        model.addAttribute("list",adminMapper.menu_info(fid));
        model.addAttribute("title","编辑");
        return "/admin/menu/edit";
    }

    /**
     * 导航栏 新增 更新
     * @param menu 导航栏对象
     * @param response 相应
     * @return 返回结果状态
     * @throws Exception 抛异常
     */
    @PostMapping("/update")
    public PrintWriter update(Menu menu, HttpServletResponse response) throws Exception {
        Integer status;
        System.out.println(menu);
        if(menu.getFid()>0){
            status=adminMapper.menu_update(menu);
        }else {
            menu.setCreate_time(new Date());
            status=adminMapper.menu_add(menu);
        }
        if(status>0){
            //数据变更保存换缓存
            RedisCache("menu_list",apiMapper.GetMenuList(),0);
        }
        return return_status(status,"/menu/index",response);
    }

    /**
     * 删除导航栏
     * @param type 删除形式  1 彻底删除 2 标记删除
     * @param fid 主键ID
     * @param response 相应
     * @return 返回执行状态
     * @throws Exception 抛异常
     */
    @PostMapping("/del")
    public PrintWriter Del(@RequestParam(value = "type",required = false) Integer type,
                           @RequestParam(value = "fid",required = false) String fid,
                           HttpServletResponse response) throws Exception{
        Integer status;
        if(type==2){
            status=adminMapper.menu_tag_delete(fid);
        }else {
            status=adminMapper.menu_delete(fid);
        }

        if(status>0){
            //数据变更保存换缓存
            RedisCache("menu_list",apiMapper.GetMenuList(),0);
        }
        return return_status(status,"/menu/index",response);
    }
}
