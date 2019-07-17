package com.example.demo.admin;

import com.example.config.Layui;
import com.example.mapper.Admin.AdminMapper;
import com.example.mapper.Api.ApiMapper;
import com.example.model.Banner;
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
@RequestMapping("/banner")
public class BannerController extends CommonController{

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
        model.addAttribute("title","轮播图列表");
        model.addAttribute("wheel_position",Class_Type());
        return "/admin/banner/index";
    }

    /**
     * 轮播图 分页查询
     * @param page   当前页
     * @param size 几条
     * @return 返回数据结构
     */
    @GetMapping("/list")
    @ResponseBody
    public Layui list(Banner banner,@RequestParam(value = "page",required = false,defaultValue = "1") int page,
       @RequestParam(value = "limit",required = false,defaultValue = "1") int size) {
        PageHelper.startPage(page,size,"fid desc");
        //3. 因为PageHelper的作用，这里就会返回当前分页的集合了
        List<Banner> cs =  adminMapper.banner_list(banner);
        //4. 根据返回的集合，创建PageInfo对象
        PageInfo<Banner> list = new PageInfo<>(cs);
        return Layui.data((int) list.getTotal(), list.getList());
    }

    /**
     * 轮播图编辑
     * @param model 模型
     * @param fid 主键id
     * @return 返回一条数据
     */
    @GetMapping("/edit")
    public String Edit(Model model,@RequestParam(value = "fid",required = false) Integer fid) {
        model.addAttribute("list",adminMapper.banner_info(fid));
        //位置分类
        model.addAttribute("location_list",Class_Type());
        model.addAttribute("title","编辑");
        return "/admin/banner/edit";
    }

    /**
     * 导航栏 新增 更新
     * @param banner 导航栏对象
     * @param response 相应
     * @return 返回结果状态
     * @throws Exception 抛异常
     */
    @PostMapping("/update")
    public PrintWriter update(Banner banner, HttpServletResponse response) throws Exception {
        Integer status;
        if(banner.getFid()>0){
            status=adminMapper.banner_update(banner);
        }else {
            banner.setCreate_time(new Date());
            status=adminMapper.banner_add(banner);
        }
        if(status==1){
            //数据变更保存换缓存
            RedisCache("banner_list_"+banner.getLocation(),apiMapper.GetBannerList(banner.getLocation()),0);
        }
        return return_status(status,"/banner/index",response);
    }

    /**
     * 删除轮播图
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
            status=adminMapper.banner_tag_delete(fid);
        }else {
            status=adminMapper.banner_delete(fid);
        }

        //批量删除处理
        String[] strArray = fid.split(",");
        if(status>0){
            Integer location;
            if(strArray.length>1){
                for(String s : strArray){
                    location = adminMapper.banner_info(Integer.valueOf(s)).getLocation();
                    //数据变更保存换缓存
                    RedisCache("banner_list_"+location,apiMapper.GetBannerList(location),0);
                }
            }else {
                location = adminMapper.banner_info(Integer.valueOf(fid)).getLocation();
                RedisCache("banner_list_"+location,apiMapper.GetBannerList(location),0);
            }
        }
        return return_status(status,"/banner/index",response);
    }
}
