<#include "../public/header.ftl"/>
<body>
<div class="x-nav">
  <span class="layui-breadcrumb">
    <a><cite>轮播管理</cite></a>
  </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i>
  </a>
</div>
<div class="x-body">

  <div class="layui-form-pane" style="text-align: center;">
    <div class="layui-form-item" style="display: inline-block;">
      <div class="layui-input-inline">
        <input type="text" id="keyword" name="string" value="" placeholder="请输入查询内容" autocomplete="off" class="layui-input">
      </div>

      <div class="layui-input-inline">
        <select name="location" id="location" lay-search="" style="height:38px;">
          <option value="" >轮播位置</option>
          <#list wheel_position as v>
            <option value="${v_index+1}" >${v}</option>
          </#list>
        </select>
      </div>

      <div class="layui-input-inline" style="width:80px">
        <button class="layui-btn" lay-submit="" lay-filter="search"  onclick="queryTea()"><i class="layui-icon">&#xe615;</i></button>
      </div>
    </div>
  </div>

  <table class="layui-hide" id="table" lay-filter="tableTool"></table>

  <script type="text/html" id="barTool">
    <div class="td-manage">
      <a title="编辑" href="javascript:;" lay-event="edit" style="text-decoration:none;margin:0 30px 0 50px">
        <i class="iconfont">&#xe6b2;</i>
      </a>
      <a title="删除" href="javascript:;" lay-event="del" style="text-decoration:none">
        <i class="iconfont">&#xe69d;</i>
      </a>
    </div>
  </script>

  <script type="text/html" id="toolbar">
    <div class="layui-btn-container">
      <button class="layui-btn" lay-event="getCheckData"><i class="layui-icon">&#xe608;</i>增加</button>
      <button class="layui-btn layui-btn-danger" lay-event="getCheckLength"><i class="layui-icon">&#xe640;</i>批量删除</button>
    </div>
  </script>

</div>

<script type="text/html" id="a">
  {{#  if(d.record_status==1){ }}
  启用
  {{#  }else { }}
  禁用
  {{#  } }}
</script>

<script type="text/html" id="b">
  {{#  if(d.file_path){ }}
  <img src="{{ d.file_path }}" />
  {{#  }else { }}
  无
  {{#  } }}
</script>

<#--控制器函数前段渲染-->
<script type="text/html" id="c">
  {{#
  var fn = function(location){
  var str = '';
  <#list wheel_position as v>
    if(location=="${v_index+1}"){
    str="${v}";
    }
  </#list>
  return str;
  };
  }}
  <div>{{ fn(d.location) }}</div>
</script>

<script>
  var table;
  layui.use(['table', 'layer'], function () {
    var layer = layui.layer;
    table = layui.table;
    table.render({
      elem: '#table'
      ,toolbar: '#toolbar'
      ,url:'/banner/list'
      , cols: [[
        {type: 'checkbox', fixed: 'left'}
        ,{ field: 'fid', width: 100, title: 'ID' , sort: true}
        , { field: 'title', title: '标题' }
        , { field: 'location',  title: '轮播位置',toolbar:"#c" }
        , { title: '图片',toolbar:"#b"}
        , { title: '此条状态',toolbar:"#a"}
        , { field: 'create_time', title: '创建时间' }
        , { fixed: 'right', title: '操作', width: 180, align: 'center', toolbar: '#barTool' }
      ]]
      ,id: 'banner'
      , page: true
    });

    //监听[头]工具栏事件
    table.on('toolbar(tableTool)', function(obj){
      var checkStatus = table.checkStatus(obj.config.id);
      var data = checkStatus.data;

      var str="";
      for (var key in data) {
        str+=data[key].fid+ ",";
      }

      //去掉最后一个逗号(如果不需要去掉，就不用写)
      if (str.length > 0) {
        str = str.substr(0, str.length - 1);
      }

      switch(obj.event){
        case 'LAYTABLE_COLS':
        case 'LAYTABLE_EXPORT':
        case 'LAYTABLE_PRINT':
          return true;
        case 'getCheckLength':
          if(str.length < 0 ){
            layer.msg('请选择要删除的数据！', {icon: 2, time:2000});
            return false;
          }
          member_del(str,'/banner/del','/banner/index');
          return true;
        case 'getCheckData':
          member_edit('编辑','/banner/edit','/banner/index',-1,'800','800');
          break;
      }
    });

    //监听[行]工具条
    table.on('tool(tableTool)', function (obj) {
      var data = obj.data;
      if (obj.event === 'del') {
        member_del(data.fid,'/banner/del','/banner/index')
      }else if (obj.event === 'edit') {
        member_edit('编辑','/banner/edit','/banner/index',data.fid,'800','800')
      }
    });

  });


  //查询 页面重载
  function queryTea(){
    var keyword = $("#keyword").val();
    var location = $("#location").val();
    //执行重载
    table.reload('banner', {
      page: {
        curr: 1 //重新从第 1 页开始
      }
      ,where: {
        title:keyword,
        location:location
      }
    });
  }
</script>
<#include "../public/top_js.ftl"/>
</body>
</html>