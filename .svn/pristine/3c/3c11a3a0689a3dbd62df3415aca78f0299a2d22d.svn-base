package com.example.model;
import com.example.config.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import java.io.Serializable;
import java.util.Date;
import lombok.Data;

@Data
public class Banner implements Serializable {
	private static final long serialVersionUID = 7202853475770976401L;
	private Integer fid;
	private String title;
	private String images_id;
	private Integer sort;
	private String record_status;
	private Integer creator_id;
	private String file_path;
	private String  jump_url;
	private Integer location;
	private String  class_name_zh;
	@JsonSerialize(using = DateSerializer.class)
	private Date create_time;//查询 开始添加时间
	@JsonSerialize(using = DateSerializer.class)
	private Date update_time;//查询 结束添加时间
}
