package com.example.demo.admin;

import com.example.config.Layui;
import com.example.mapper.Admin.AdminMapper;
import com.example.model.FeedBack;
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
@RequestMapping("/user")
public class UserController extends CommonController{

    @Autowired
    private AdminMapper adminMapper;

    /**
     * 首页
     * @param model 模型
     * @return 返回视图
     */
    @RequestMapping("/feedback")
    public String FeedBack(Model model) {
        model.addAttribute("title","用户反馈");
        return "/admin/user/feedback";
    }

    /**
     * 分页查询
     * @param page   当前页
     * @param size 几条
     * @return 返回数据结构
     */
    @GetMapping("/feedback_list")
    @ResponseBody
    public Layui FeedBackList(@RequestParam(value = "page",required = false,defaultValue = "1") int page,
       @RequestParam(value = "limit",required = false,defaultValue = "1") int size,FeedBack feedback) {
        PageHelper.startPage(page,size,"fid desc");
        List<FeedBack> cs =  adminMapper.feedback_list(feedback);
        System.out.print(cs);
        PageInfo<FeedBack> list = new PageInfo<>(cs);
        return Layui.data((int) list.getTotal(), list.getList());
    }

    /**
     * 编辑
     * @param model 模型
     * @param fid 主键id
     * @return 返回一条数据
     */
    @GetMapping("/feedback_edit")
    public String FeedBackEdit(Model model,@RequestParam(value = "fid",required = false) Integer fid) {
        model.addAttribute("list",adminMapper.feedback_info(fid));
        System.out.print(adminMapper.feedback_info(fid));
        model.addAttribute("title","编辑");
        return "/admin/user/feedback_edit";
    }

    /**
     *  新增 更新
     * @param feedback 相应
     * @return 返回结果状态
     * @throws Exception 抛异常
     */
    @PostMapping("/feedback_update")
    public PrintWriter FeedBackUpdate(FeedBack feedback, HttpServletResponse response) throws Exception {
        Integer status;
        status=adminMapper.feedback_update(feedback);
        return return_status(status,"/user/feedback",response);
    }

    /**
     * 删除
     * @param type 删除形式  1 彻底删除 2 标记删除
     * @param fid 主键ID
     * @param response 相应
     * @return 返回执行状态
     * @throws Exception 抛异常
     */
    @PostMapping("/feedback_del")
    public PrintWriter FeedBackDel(@RequestParam(value = "type",required = false) Integer type,
                           @RequestParam(value = "fid",required = false) String fid,
                           HttpServletResponse response) throws Exception{
        Integer status;
        if(type==2){
            status=adminMapper.feedback_tag_delete(fid);
        }else {
            status=adminMapper.feedback_delete(fid);
        }
        return return_status(status,"/user/feedback",response);
    }
}
