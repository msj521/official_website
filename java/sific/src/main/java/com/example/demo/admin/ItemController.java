package com.example.demo.admin;

import com.example.config.Layui;
import com.example.mapper.Admin.AdminMapper;
import com.example.mapper.Api.ApiMapper;
import com.example.model.ClassType;
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

@Controller
@RequestMapping("/item")
public class ItemController extends CommonController{

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
    public String ItemClass(Model model) {
        model.addAttribute("title","分类列表");
        model.addAttribute("wheel_position",Class_Type());
        return "/admin/item/index";
    }

    /**
     * 分页查询
     * @param page   当前页
     * @param size 几条
     * @return 返回数据结构
     */
    @GetMapping("/list")
    @ResponseBody
    public Layui list(ClassType classType,
       @RequestParam(value = "page",required = false,defaultValue = "1") int page,
       @RequestParam(value = "limit",required = false,defaultValue = "1") int size) {
        PageHelper.startPage(page,size,"fid desc");
        List<ClassType> cs;
        cs =  adminMapper.class_list(classType);
        PageInfo<ClassType> list = new PageInfo<>(cs);
        return Layui.data((int) list.getTotal(), list.getList());
    }

    /**
     * 编辑
     * @param model 模型
     * @param fid 主键id
     * @return 返回一条数据
     */
    @GetMapping("/edit")
    public String Edit(Model model,@RequestParam(value = "fid",required = false) Integer fid) {
        model.addAttribute("list",adminMapper.class_info(fid));
        //位置分类
        model.addAttribute("location_list",Class_Type());
        model.addAttribute("title","编辑");
        return "/admin/item/edit";
    }

    /**
     *  新增 更新
     * @param classType 对象
     * @param response 相应
     * @return 返回结果状态
     * @throws Exception 抛异常
     */
    @PostMapping("/update")
    public PrintWriter update(ClassType classType, HttpServletResponse response) throws Exception {
        Integer status;
        if(classType.getFid()!=null){
            status=adminMapper.class_update(classType);
        }else {
            classType.setCreate_time(new Date());
            status=adminMapper.class_add(classType);
        }
        if(status>0){
            //数据变更保存换缓存
            Integer class_type=classType.getClass_type();
            RedisCache("class_list_"+class_type,apiMapper.GetClassList(class_type),0);
        }
        return return_status(status,"/item/index",response);
    }

    /**
     * 删除
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
            status=adminMapper.class_tag_delete(fid);
        }else {
            status=adminMapper.class_delete(fid);
        }
        //批量删除处理
        String[] strArray = fid.split(",");
        if(status>0){
            Integer class_type;
            if(strArray.length>1){
                for(String s : strArray){
                    class_type=adminMapper.class_info(Integer.valueOf(s)).getClass_type();
                    //数据变更保存换缓存
                    RedisCache("class_list_"+class_type,apiMapper.GetClassList(class_type),0);
                }
            }else {
                class_type=adminMapper.class_info(Integer.valueOf(fid)).getClass_type();
                RedisCache("class_list_"+class_type,apiMapper.GetClassList(class_type),0);
            }
        }
        return return_status(status,"/item/index",response);
    }
}
