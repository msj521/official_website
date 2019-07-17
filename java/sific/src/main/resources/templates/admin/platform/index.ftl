<#include "../public/header.ftl"/>
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
              <a><cite>基础资料</cite></a>
              <a><cite>官网声明</cite></a>
            </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"
     href="javascript:location.replace(location.href);" title="刷新">
    <i class="layui-icon" style="line-height:30px">ဂ</i>
  </a>
</div>
<xblock>
  <span class="layui-btn" style="line-height:40px">共有数据：1 条</span>
</xblock>

<table class="layui-hide" id="table" lay-filter="tableTool"></table>

<#include "../public/top_js.ftl"/>

<script type="text/html" id="a">
  <a  href="javascript:;"  lay-event="A"
      class="ml-5" style="text-decoration:none" ><i class="iconfont">&#xe6f5;</i></a>
</script>

<script type="text/html" id="b">
  <a  href="javascript:;"  lay-event="B"
      class="ml-5" style="text-decoration:none" ><i class="iconfont">&#xe6b3;</i></a>
</script>

<script type="text/html" id="c">
  <a  href="javascript:;"  lay-event="C"
      class="ml-5" style="text-decoration:none" ><i class="iconfont">&#xe724;</i></a>
</script>

<script type="text/html" id="d">
  <a  href="javascript:;"  lay-event="D"
      class="ml-5" style="text-decoration:none" ><i class="iconfont">&#xe705;</i></a>
</script>

<script type="text/html" id="e">
  <a  href="javascript:;"  lay-event="E"
      class="ml-5" style="text-decoration:none" ><i class="iconfont">&#xe6c7;</i></a>
</script>

<script type="text/html" id="f">
  <a  href="javascript:;"  lay-event="F"
      class="ml-5" style="text-decoration:none" ><i class="iconfont">&#xe725;</i></a>
</script>

<script>
  var table;
  layui.use(['table', 'layer'], function () {
    var layer = layui.layer;
    table = layui.table;
    table.render({
      elem: '#table'
      ,url:'/platform/list'
      ,page :false
      , cols: [[
        { field: 'fid', width: 80, title: 'ID', sort: true }
        , { title: '简介', toolbar: '#a' }
        , { title: '联系我们', toolbar: '#b' }
        , { title: '使命', toolbar: '#c' }
        , { title: '核心价值', toolbar: '#d' }
        , { title: '愿景', toolbar: '#e' }
        , { title: '发展历程', toolbar: '#f' }
      ]]
    });

    //监听工具条
    table.on('tool(tableTool)', function (obj) {
      var data = obj.data;
      if (obj.event === 'A') {
        member_edit('简介', '/platform/edit', '/platform/index', data.fid + '&type=A',1000, 600)
      } else if (obj.event === 'B') {
        member_edit('联系我们', '/platform/edit', '/platform/index', data.fid + '&type=B', 1000, 600)
      } else if (obj.event === 'C') {
        member_edit('使命', '/platform/edit', '/platform/index', data.fid + '&type=C', 1000, 600)
      } else if (obj.event === 'D') {
        member_edit('核心价值', '/platform/edit', '/platform/index', data.fid + '&type=D', 1000, 600)
      } else if (obj.event === 'E') {
        member_edit('愿景', '/platform/edit', '/platform/index', data.fid + '&type=E', 1000, 600)
      } else if (obj.event === 'F') {
        member_edit('发展历程', '/platform/edit', '/platform/index', data.fid + '&type=F', 1000, 600)
      }
    });
  })
</script>
</body>
</html>