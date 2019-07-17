package com.example.model;
import com.example.config.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;
@Data
public class Product implements Serializable {
    private static final long serialVersionUID = -1722714541394171066L;
    private Integer fid;
    private Integer class_type;
    private Integer class_id;
    private String  title;
    private String  digest;
    private String  jump_url;
    private String  content;
    private Integer images_id;
    private Integer sort;
    private Integer record_status;
    private Integer creator_id;
    @JsonSerialize(using = DateSerializer.class)
    private Date create_time;//查询 开始添加时间
    @JsonSerialize(using = DateSerializer.class)
    private Date update_time;//查询 结束添加时间
    private String  file_path;
    private String  data_images;
    private String  images_list;
    private String  class_name_zh;
    private String  class_name_type;
}
