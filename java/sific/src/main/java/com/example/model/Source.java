package com.example.model;
import com.example.config.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;
@Data
public class Source implements Serializable {
    private static final long serialVersionUID = -5881416787437583017L;
    private Integer fid;
    private String  file_name;
    private String  file_path;
    private Integer source_type;
    private Long    file_size;
    private Integer record_status;
    private Integer creator_id;
    @JsonSerialize(using = DateSerializer.class)
    private Date create_time;//查询 开始添加时间
    @JsonSerialize(using = DateSerializer.class)
    private Date update_time;//查询 结束添加时间
}
