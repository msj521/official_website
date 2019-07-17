package com.example.demo.admin;

import com.example.config.Layui;
import com.example.mapper.Admin.AdminMapper;
import com.example.model.AboutUs;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/platform")
public class PlatformController extends CommonController{

    @Autowired
    private AdminMapper adminMapper;
    /**
     * 首页
     * @param model 模型
     * @return 返回视图
     */
    @RequestMapping("/index")
    public String platform(Model model) {
        model.addAttribute("title","官网声明");
        return "/admin/platform/index";
    }

    /**
     * 导航栏 分页查询
     * @param page   当前页
     * @param size 几条
     * @return 返回数据结构
     */
    @GetMapping("/list")
    @ResponseBody
    public Layui list(@RequestParam(value = "page",required = false,defaultValue = "1") int page,
                      @RequestParam(value = "limit",required = false,defaultValue = "1") int size) {
        PageHelper.startPage(page,size,"fid desc");
        List<AboutUs> cs =  adminMapper.platform_list();
        PageInfo<AboutUs> list = new PageInfo<>(cs);
        return Layui.data((int) list.getTotal(), list.getList());
    }

    /**
     * 编辑
     * @param model 模型
     * @param fid 主键id
     * @return 返回一条数据
     */
    @GetMapping("/edit")
    public String Edit(Model model,@RequestParam(value = "fid",required = false) Integer fid,
                        @RequestParam(value = "type",required = false) String type) {
        AboutUs info=adminMapper.platform_info(fid);

        String  theme;
        String  filed;
        String  result;
        if(type.equals("A")){
            theme="简介";
            filed="about_us";
            result=info.getAbout_us();
        }else if(type.equals("B")){
            theme="联系我们";
            filed="contact_us";
            result=info.getContact_us();
        }else if(type.equals("C")){
            theme="使命";
            filed="mission";
            result=info.getMission();
        }else if(type.equals("D")){
            theme="核心价值";
            filed="core_value";
            result=info.getCore_value();
        }else if(type.equals("E")){
            theme="愿景";
            filed="vision";
            result=info.getVision();
        }else if(type.equals("F")){
            theme="发展历程";
            filed="course";
            result=info.getCourse();
        }else{
            theme="联系我们";
            filed="contact_us";
            result=info.getAbout_us();
        }
        model.addAttribute("field",filed);
        model.addAttribute("title",theme);
        model.addAttribute("fid",fid);
        model.addAttribute("result",result);
        return "/admin/platform/edit";
    }

    /**
     *  新增 更新
     * @param aboutUs 对象
     * @param response 相应
     * @return 返回结果状态
     * @throws Exception 抛异常
     */
    @PostMapping("/update")
    public PrintWriter update(AboutUs aboutUs, HttpServletResponse response) throws Exception {
        Integer status=adminMapper.platform_update(aboutUs);
        if(status==1){
            //数据变更保存换缓存
            RedisCache("about_info",adminMapper.platform_list(),0);
        }
        return return_status(status,"/platform/index",response);
    }
}
