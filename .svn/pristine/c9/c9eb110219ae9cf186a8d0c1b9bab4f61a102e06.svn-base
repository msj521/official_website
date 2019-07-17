package com.example.model;

import java.io.Serializable;
import java.util.Date;

import com.example.config.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;
@Data
public class User implements Serializable {
	private static final long serialVersionUID = -5881416787437583017L;
	private int fid;
	private String user_name;
	private String password;
	private String email;
	private String record_status;
	private String tel;
	@JsonSerialize(using = DateSerializer.class)
	private Date create_time;//查询 开始添加时间
	@JsonSerialize(using = DateSerializer.class)
	private Date update_time;//查询 结束添加时间
}
