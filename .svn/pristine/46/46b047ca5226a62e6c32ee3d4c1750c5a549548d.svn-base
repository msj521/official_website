package com.example.model;
import java.io.Serializable;
import java.util.Date;
import com.example.config.DateSerializer;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Data;
@Data
public class Menu implements Serializable {
	private static final long serialVersionUID = -4962664000984108291L;
	private Integer fid;
	private String menu_name;
	private String route;
	private Integer sort;
	private Integer type;
	private String record_status;
	@JsonSerialize(using = DateSerializer.class)
	private Date create_time;//查询 开始添加时间
	@JsonSerialize(using = DateSerializer.class)
	private Date update_time;//查询 结束添加时间
	private String icon_cls;
}
