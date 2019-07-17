package com.example.demo.admin;

import com.example.config.Layui;
import com.example.mapper.Admin.AdminMapper;
import com.example.model.News;
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
@RequestMapping("/news")
public class NewsController extends CommonController{

    @Autowired
    private AdminMapper adminMapper;

    /**
     * 首页
     * @param model 模型
     * @return 返回视图
     */
    @RequestMapping("/index")
    public String News(Model model) {
        model.addAttribute("title","新闻中心");
        model.addAttribute("new_class",adminMapper.get_class(4));
        return "/admin/news/index";
    }

    /**
     * 分页查询
     * @param page   当前页
     * @param size 几条
     * @return 返回数据结构
     */
    @GetMapping("/list")
    @ResponseBody
    public Layui list(@RequestParam(value = "page",required = false,defaultValue = "1") int page,
       @RequestParam(value = "limit",required = false,defaultValue = "1") int size,News news) {
        PageHelper.startPage(page,size,"fid desc");
        List<News> cs;
        cs =  adminMapper.news_list(news);
        PageInfo<News> list = new PageInfo<>(cs);
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
        model.addAttribute("list",adminMapper.news_info(fid));
        //位置分类
        model.addAttribute("new_class",adminMapper.get_class(4));
        model.addAttribute("title","编辑");
        return "/admin/news/edit";
    }

    /**
     *  新增 更新
     * @param news 对象
     * @param response 相应
     * @return 返回结果状态
     * @throws Exception 抛异常
     */
    @PostMapping("/update")
    public PrintWriter update(News news, HttpServletResponse response) throws Exception {
        Integer status;
        Integer fid=news.getFid();

        if(fid>0){
            status=adminMapper.news_update(news);
        }else {
            news.setCreate_time(new Date());
            status=adminMapper.news_add(news);
        }
        if(status==1){
            //数据变更保存换缓存
            RedisCache("news_list",apiMapper.GetNewsList(),0);
        }
        return return_status(status,"/news/index",response);
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
            status=adminMapper.news_tag_delete(fid);
        }else {
            status=adminMapper.news_delete(fid);
        }

        if(status>0){
            //数据变更保存换缓存
            RedisCache("news_list",apiMapper.GetNewsList(),0);
        }
        return return_status(status,"/news/index",response);
    }
}
