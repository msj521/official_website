package com.example.mapper.Api;

import com.example.model.*;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/*接口列表*/
public interface ApiMapper {

    //轮播图
    List<Banner> GetBannerList(Integer location);

    //关于康尔泰
    AboutUs GetAboutInfo();

    //导航栏
    List<Menu> GetMenuList();

    //首页  产品中心  成功案例分类
    List<ClassType> GetClassList(Integer type);

    //首页新闻
    List<News> GetNewsListIndex();

    //新闻中心
    List<News> GetNewsList();

    //新闻详情
    List<News> GetNewsInfo(Integer fid);

    //产品中心
    List<Product> GetProductInfo(Integer class_type,Integer class_id);

    //数据提交联系我们
    Integer InsertFeedBack(FeedBack feedback);

    /*图片信息保存*/
    @Insert("INSERT INTO base_source_info(file_name,file_path,file_size,record_status)VALUES(#{file_name},#{file_path},#{file_size},#{record_status})")
    @SelectKey(statement="select LAST_INSERT_ID()", keyProperty="fid", before=false, resultType=int.class)
    Integer image_add(Source source);

    @Update("update base_source_info set file_name=#{file_name},file_path=#{file_path},file_size=#{file_size} where fid=#{fid}")
    Integer image_update(Source source);
}
