package com.example.model;
import java.io.Serializable;
import java.util.Date;

import com.example.config.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;

@Data
public class AboutUs implements Serializable {
    private static final long serialVersionUID = -5881416787437583017L;
    private Integer fid;
    private String  about_us;
    private String  vision;
    private String  mission;
    private String  course;
    private String  core_value;
    private String  statement;
    private String  disclaimer;
    private String  report_complaints;
    private String  opinion;
    private String  contact_us;
    private Integer sort;
    private Integer record_status;
    private Integer updater_id;
    private Integer creator_id;
    @JsonSerialize(using = DateSerializer.class)
    private Date create_time;//查询 开始添加时间
    @JsonSerialize(using = DateSerializer.class)
    private Date update_time;//查询 结束添加时间
}