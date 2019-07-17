{include file="public/header" /}

<style type="text/css">
  /*隐藏全选checkbox*/
  .layui-table th .layui-unselect{
      display: none;
  }
</style>
<body>
        <!-- 右侧主体结束 -->
    <div class="x-body layui-anim layui-anim-up">
        <!-- 右侧内容框架，更改从这里开始 -->
        <form class="layui-form"  action="{$update}" method="post" enctype="multipart/form-data">
            <div class="layui-form-item">
              <label class="layui-form-label">昵称</label>
              <div class="layui-input-block">
                <input type="text" required name="nick_name" lay-verify="title" autocomplete="off" placeholder="请输入昵称" class="layui-input" value="{$data['user_info']['nick_name']|default=''}">
              </div>
            </div>

            <div class="layui-form-item">
              <label class="layui-form-label">姓名<?php html_sign();?></label>
              <div class="layui-input-block">
                <input type="text"  name="user_name" lay-verify="required" autocomplete="off" placeholder="请输入姓名" class="layui-input" value="{$data['user_info']['user_name']|default=''}">
              </div>
            </div>

          <div class="layui-form-item">
            <label class="layui-form-label">头像上传<?php html_sign();?></label>
            <div class="layui-upload">
              <div style="float: left; width: 150px; text-align: center;">
                <button type="button" class="layui-btn" id="img">头像图片</button>
                <div class="layui-upload-list">
                  <img class="layui-upload-img" id="img1" width="150" src="{$data['user_info']['image_url']|default=''}">
                </div>
              </div>
            </div>
          </div>

            <input type="hidden" name="fid" value="{$data['user_info']['fid']|default='0'}">
            <input type="hidden" name="web_image_id" id="FImageUrl" value="{$data['user_info']['web_image_id']|default=''}">
            <input type="hidden" name="app_image_id" id="FImageUrls" value="{$data['user_info']['app_image_id']|default=''}">
            <div class="layui-form-item">
              <label class="layui-form-label">电话<?php html_sign();?></label>
              <div class="layui-input-block">
                <input type="text"  name="tel" lay-verify="required" autocomplete="off" placeholder="请输入电话" class="layui-input" value="{$data['user_info']['tel']|default=''}">
              </div>
            </div>

            <div class="layui-form-item">
              <label class="layui-form-label">密码<?php html_sign();?></label>
              <div class="layui-input-block">
                <input type="password" required name="password" lay-verify="required" autocomplete="off" placeholder="请输入密码" class="layui-input" value="{$data['user_info']['password']|default=''}">
              </div>
            </div>

            <div class="layui-form-item">
              <label class="layui-form-label">邮箱<?php html_sign();?></label>
              <div class="layui-input-block">
                <input type="text" name="email"  required lay-verify="required" autocomplete="off" placeholder="请输入邮箱" class="layui-input" value="{$data['user_info']['email']|default=''}">
              </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label for="description" class="layui-form-label">简介</label>
                <div class="layui-input-block" >
                    <textarea placeholder="请输入简介" id="description" name="description" autocomplete="off"
                    class="layui-textarea" style="height: 80px;">{$data['user_info']['description']|default=''}</textarea>
                </div>
            </div>


            <div class="layui-form-item">
                <label class="layui-form-label xbs768">职称</label>
                <div class="layui-input-inline">
                  <select name="job_id" lay-verify="" lay-search="" >
                    <option value="">直接选择或搜索选择</option>
                    {volist name="job" key="k" id="v"}
                    <option value="{$v.fid}"
                            {if condition="isset($data['user_info']['job_id']) && $data['user_info']['job_id'] eq $v['fid']" } selected="selected" {/if}>{$v.class_name_zh}</option>
                    {/volist}
                  </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label xbs768">学历</label>
                <div class="layui-input-inline">
                  <select name="education_id" lay-verify="" lay-search="" >
                    <option value="">直接选择或搜索选择</option>
                    {volist name="edu" key="k" id="v"}
                    <option value="{$v.fid}"
                            {if condition="isset($data['user_info']['education_id']) && $data['user_info']['education_id'] eq $v['fid']" } selected="selected" {/if}>{$v.class_name_zh}</option>
                    {/volist}
                  </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label xbs768">机构/单位</label>
                <div class="layui-input-block">
                  <select name="org_id" lay-verify="" lay-search="" >
                    <option value="">直接选择或搜索选择</option>
                    {volist name="org" key="k" id="v"}
                    <option value="{$v.fid}"
                            {if condition="isset($data['user_info']['org_id']) && $data['user_info']['org_id'] eq $v['fid']" } selected="selected" {/if}>{$v.org_name}</option>
                    {/volist}
                  </select>
                </div>
            </div>

            <div class="layui-form-item">
              <label class="layui-form-label">自定义机构</label>
              <div class="layui-input-block">
                <input type="text" name="diy_org" lay-verify="title" autocomplete="off" placeholder="请输入自定义机构或单位" class="layui-input" value="{$data['user_info']['diy_org']|default=''}">
              </div>
            </div>

            <div class="layui-form-item">
              <label class="layui-form-label">部门</label>
              <div class="layui-input-block">
                <input type="text" name="department" lay-verify="title" autocomplete="off" placeholder="请输入部门" class="layui-input" value="{$data['user_info']['department']|default=''}">
              </div>
            </div>

            <table class="layui-hide" id="role" lay-data="{id:'myTable'}" lay-filter="myTable"></table>
            <input type="hidden" name="role">

            <div class="layui-form-item">
              <label class="layui-form-label xbs768">状态</label>
              <div class="layui-input-block">
                <input type="radio" name="record_status" value="1" title="启用" checked>
                <input type="radio" name="record_status" value="2" title="禁用" {if condition="isset($data['user_info']['record_status']) && $data['user_info']['record_status'] eq 2"} checked {/if}>
                <input type="radio" name="record_status" value="-1" title="标记删除" {if condition="isset($data['user_info']['record_status']) &&  $data['user_info']['record_status'] eq -1"} checked {/if}>
              </div>
            </div>

            <div class="layui-form-item">
              <label  class="layui-form-label"></label>
              <button class="layui-btn" lay-filter="add" lay-submit="">保存</button>
            </div>
        </form>
        <!-- 右侧内容框架，更改从这里结束 -->
    </div>
    <!-- 中部结束 -->

</body>

<script>
  layui.use('upload',function(){
    var upload = layui.upload;
    var web_image_id='{$data.user_info.web_image_id|default=0}';
    var app_image_id='{$data.user_info.app_image_id|default=0}';
    //普通图片上传
    upload.render({
      elem: '#img'
      ,url: '/upload'
      ,data: {web_image_id:web_image_id,app_image_id:app_image_id}
      ,acceptMime: 'image/*'
      ,before: function(obj){
        obj.preview(function(index, file, result){
          $('#img1').attr('src', result);
        });
      }
      ,done: function(res){
        //如果上传失败
        console.log(res);
        if(res.code==200){
          $('#FImageUrl,#FImageUrls').attr('value', res.data);
          return layer.msg('上传成功');
        }else{
          return layer.msg('上传失败');
        }
      }
    });

  });

  layui.use(['jquery','form','layer', 'table'], function(){
    var form = layui.form;
    var table = layui.table;

    var fid ='{$data["user_info"]["fid"]||default=0}';

    /*//加载权限表
    $.ajax({
        url: '/role/list?fid='+fid,
        dataType: 'json',
        method: 'GET',
        success: function(data) {
           table.render({
              elem: '#role'
              ,cols: [[
                {type:'checkbox'}
                ,{field:'FRoleName', title: '权限组名称'}
              ]],
              data:data
            });

           //保存原始权限数据
           for (var i = 0; i < data.length; i++) {
            if (data[i]['LAY_CHECKED']==1) {
               selectRole.push(data[i]['fid']);
            }
           }
           $("input[name='role']").val(JSON.stringify(selectRole));
        },
        error: function(xhr) {
           // 导致出错的原因较多，以后再研究
           //alert('error:' + JSON.stringify(xhr));
        }
     });*/

    //选中权限的监听事件
    var selectRole = [];
     table.on('checkbox(myTable)',function(obj){
        var check = obj.checked;
        // var type = obj.type;
        var data = obj.data;

        var index = selectRole.indexOf(data.fid);
        if (index > -1) {
            selectRole.splice(index, 1);
        }
        if (check) {
          selectRole.push(data.fid);
        } 
         $("input[name='role']").val(JSON.stringify(selectRole));
    })
    
  });
</script>
</html>