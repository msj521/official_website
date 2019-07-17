 {include file="public/header" /}
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
              <a><cite>用户管理</cite></a>
              <a><cite>{$title}</cite></a>
            </span>
  <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right"  href="javascript:location.replace(location.href);" title="刷新"><i class="layui-icon" style="line-height:30px">ဂ</i></a>
</div>


<div class="x-body">
  <!-- 右侧内容框架，更改从这里开始 -->
  <form class="layui-form xbs" action="{$index}" method="get">
    <div class="layui-form-pane" style="text-align: center;">
      <div class="layui-form-item" style="display: inline-block;">
        <div class="layui-input-inline">
          <input type="text" name="user_name" value="{$user_name}" placeholder="用户名,姓名,电话或机构" autocomplete="off" class="layui-input">
        </div>
        <div class="layui-input-inline" style="width:80px">
          <button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        </div>
      </div>
    </div>
  </form>
  <xblock>

               <button class="layui-btn" onclick="member_add('用户新增','{$edit}','','')"><i class="layui-icon">&#xe608;</i>添加</button>

                <button class="layui-btn layui-btn-danger" onclick="member_del(-1,'{$del}','{$index}')"><i class="layui-icon">&#xe640;</i>批量删除</button>

    <span class="x-right" style="line-height:40px">共有数据：{$cnt} 条</span></xblock>
  <table class="layui-table">
    <thead>
    <tr>
      <th style="width:20px;">
        <div class="layui-unselect header layui-form-checkbox" lay-skin="primary"><i class="layui-icon">&#xe605;</i></div>
      </th>
      <th style="width:40px;">ID</th>
      <th>用户名</th>
      <th>昵称</th>
      <th>电话</th>
      <th>邮箱</th>
      <th>注册时间</th>
      <th>直播通讯状态</th>
      <th>状态</th>
      <th style="width:120px;">操作</th>
    </tr>
    </thead>
    <tbody>
    {volist name="list" id="vo"}
    <tr>
      <td>
        <div class="layui-unselect layui-form-checkbox" lay-skin="primary" data-id='{$vo.fid}'>
          <i class="layui-icon">&#xe605;</i>
        </div>
      </td>
      <td>{$vo.fid}</td>
      <td>{$vo.user_name}</td>
      <td >{$vo.nick_name}</td>
      <td >{$vo.tel}</td>
      <td >{$vo.email}</td>
      <td >{$vo.create_time}</td>
      <td >
        {if condition="$vo.prohibit_status eq 1 "}
        <span style="color: #4ae18e; margin-right: 25px;">正常</span>
        <a href="javascript:;" class="layui-btn layui-btn-primary" onclick="prohibit_status('{$vo.fid}',2)" class="ml-5" style="color: #e1504a;text-decoration:none">禁言</a>
        {elseif condition="$vo.prohibit_status eq 2 "}
          <span style="color: #e1504a;margin-right: 25px;">禁言</span>
        <a  href="javascript:;" class="layui-btn layui-btn-primary" onclick="prohibit_status('{$vo.fid}',1)" class="ml-5" style="color: #4ae18e;text-decoration:none">恢复</a>
        {/if}
      </td>
      <td >{$vo.record_status|is_status}</td>
      <td class="td-manage">
          <a title="编辑" href="javascript:;" onclick="member_edit('编辑','{$edit}','{$index}','{$vo.fid}','','')"
             class="ml-5" style="text-decoration:none"><i class="layui-icon" >&#xe642;</i>
          </a>
          <a title="删除" href="javascript:;" onclick="member_del('{$vo.fid}','{$del}','{$index}')"
             style="text-decoration:none"><i class="layui-icon">&#xe640;</i>
          </a>
      </td>
    </tr>
    {/volist}
    </tbody>
  </table>

  <div class="page">
    {$list->render()}
  </div>
</div>
{include file="public/top_js" /}
<script>
  layui.use(['element','laypage','layer'], function(){
    $ = layui.jquery;//jquery
    laypage = layui.laypage;//分页
    layer = layui.layer;//弹出层

  });

  // 用户-编辑
  function member_add(title,url,urls,w,h){
    x_admin_show(title,url,urls);
  }

    //发异步修改推流状态
  function prohibit_status(fid,status) {
    var urls="/user/index";
      $.ajax({
      type: "post",
      url: '/user/update',
      data: {fid: fid,prohibit_status:status},
      dataType: "json",
      success: function (data) {
        if (data > 0) {
          layer.msg("操作成功", { icon: 1, time: 1000 });
        } else {
          layer.msg("操作失败" + data, { icon: 1, time: 1000 });
        }
        setTimeout(function () {
          window.location.href = urls;
        }, 1000);
      }
  });
}
</script>
</body>
</html>