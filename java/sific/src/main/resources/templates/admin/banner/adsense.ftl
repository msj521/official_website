{include file="public/header" /}
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
              <a><cite>推荐管理</cite></a>
              <a><cite>{$title|default='广告位'}</cite></a>
            </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>


<div class="x-body">
  <!-- 右侧内容框架，更改从这里开始 -->
  <form class="layui-form xbs" action="{$index|default='/'}">
    <div class="layui-form-pane" style="text-align: center;">
      <div class="layui-form-item" style="display: inline-block;">
        <div class="layui-input-inline">
          <select name="module" lay-search="">
            <option value="">所属模块</option>
            {volist name="class" key="ko" id="vo"}
            <option value="{$ko}"  {if condition="$ko eq $module"} selected="selected" {/if} >{$vo}</option>
            {/volist}
          </select>
        </div>

        <div class="layui-input-inline">
          <input type="text" name="string" placeholder="" autocomplete="off" class="layui-input" value="{$string}">
        </div>
        <div class="layui-input-inline" style="width:80px">
          <button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </div>
      </div>
    </div>
  </form>

  <xblock>
    <button class="layui-btn" onclick="member_edit('添加','{$edit|default='/'}','{$index|default='/'}','')"><i class="layui-icon">&#xe608;</i>添加</button>
<!--     <button class="layui-btn layui-btn-danger" onclick="member_del(-1,'{$del|default='/'}','{$index|default='/'}')"><i class="layui-icon">&#xe640;</i>批量删除</button> -->
    <span class="x-right" style="line-height:40px">共有数据：{$cnt} 条</span>
  </xblock>


  <table class="layui-hide" id="table" lay-filter="tableTool"></table>

  <div class="page">
    {$list->render()}
  </div>

</div>
{include file="public/top_js" /}

<script type="text/html" id="barTool">
    <div class="td-manage">
          <a title="编辑" href="javascript:;"  lay-event="edit"
             class="ml-5" style="text-decoration:none" 
            ><i class="iconfont" >&#xe69e;</i>
          </a>
          
          <a title="删除" href="javascript:;" lay-event="del"
             style="text-decoration:none">
            <i class="iconfont">&#xe69d;</i>
          </a>
  </div>
</script>

<script>
  var dataList = <?php echo json_encode($list);?>;
  console.log(dataList);
  for (var i = 0; i < dataList.data.length; i++) {

    if (dataList.data[i].sort==1){
      dataList.data[i].sort = '一级置顶';
    }else if(dataList.data[i].sort==2){
      dataList.data[i].sort = '二级置顶';
    }else if(dataList.data[i].sort==3){
      dataList.data[i].sort = '三级置顶';
    }else{
      dataList.data[i].sort = '普通';
    }

    if(dataList.data[i].module==1){
        dataList.data[i].module='首页';
    }else if(dataList.data[i].module==2){
        dataList.data[i].module='会议';
    }else if(dataList.data[i].module==3){
        dataList.data[i].module='直播';
    }else if(dataList.data[i].module==4){
        dataList.data[i].module='培训';
    }
    if(dataList.data[i].level==1){
        dataList.data[i].level='1级';
    }else if(dataList.data[i].level==2){
        dataList.data[i].level='2级';
    }else if(dataList.data[i].level==3){
        dataList.data[i].level='3级';
    }else if(dataList.data[i].level==4){
        dataList.data[i].level='4级';
    }

    if(dataList.data[i].number_id==1){
        dataList.data[i].number_id='1号位';
    }else if(dataList.data[i].number_id==2){
        dataList.data[i].number_id='2号位';
    }else if(dataList.data[i].number_id==3){
        dataList.data[i].number_id='3号位';
    }

    if(dataList.data[i].record_status==1){
        dataList.data[i].record_status='启用';
    }else if(dataList.data[i].record_status==2){
        dataList.data[i].record_status='禁用';
    }else if(dataList.data[i].record_status==-1){
        dataList.data[i].record_status='标记删除';
    }else if(dataList.data[i].record_status==-2){
        dataList.data[i].record_status='彻底删除';
    }
  }

  layui.use(['table','layer'],function(){
    var layer = layui.layer;
    var table = layui.table;
    table.render({
      elem: '#table'
      ,data: dataList.data
      ,cols: [[
        {field:'fid', width:80, title: 'ID'}
        ,{field:'title',  width:178, title: '广告标题'}
        ,{title: 'web图片',templet: '<div><img src="{{d.web_image_url}}" ></div>'}   
        ,{title: 'app图片',templet: '<div><img src="{{d.app_image_url}}" ></div>'} 
        ,{field:'source',  title: '来源'}
        ,{field:'module', title: '所属模块'}
        ,{field:'level',title: '页面级别'}  
        ,{field:'number_id',title: '广告位'}  
        ,{title: '跳转URL',width:200,templet: '<div><a target="_blank" href="{{d.url}}">{{d.url}}</a></div>'}  
        ,{field:'user_name',  title: '创建者'}
        ,{field:'record_status',  title: '状态'}
        ,{field:'create_time', width:160,  title: '创建时间'}       
        ,{fixed: 'right', width:178, align:'center', toolbar: '#barTool'}
      ]]
      ,page: false
      ,limit: dataList.data.length
    });

    //监听工具条
    table.on('tool(tableTool)', function(obj){
      var data = obj.data;
      if(obj.event === 'del'){
        member_del(data.fid,'{$del|default="/"}','{$index|default="/"}')
      }else if(obj.event === 'edit'){
        member_edit('编辑','{$edit|default="/"}','{$index|default="/"}',data.fid,0,0)
      }
    });
  })
</script>
</body>
</html>