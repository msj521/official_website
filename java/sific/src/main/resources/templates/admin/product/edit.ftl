<#include "../public/header.ftl"/>
<body>
<div class="x-body layui-anim layui-anim-up">
  <form action="/product/update"  class="layui-form" method="post" enctype="multipart/form-data" >

    <div class="layui-form-item">
      <label for="class_type"  class="layui-form-label">类型</label>
      <div class="layui-input-block">
        <select name="class_type"   id="class_type"  lay-search="" lay-verify="class_type"   lay-filter="class_type">
          <#if (list??)>
            <option value=1 <#if (list.class_type ==1) >selected="selected"</#if> >产品中心</option>
            <option value=2 <#if (list.class_type ==2) >selected="selected"</#if>>成功案例</option>
          <#else>
            <option value=1 >产品中心</option>
            <option value=2 >成功案例</option>
          </#if>
        </select>
      </div>
    </div>

    <div class="layui-form-item">
      <label for="class_id" class="layui-form-label" id="class_name">分类</label>
      <div class="layui-input-block" id="class">
        <select  lay-search="" lay-verify="select" id="nt" name="class_id" ></select>
      </div>
    </div>


    <div class="layui-form-item">
      <label title class="layui-form-label">名称</label>
      <div class="layui-input-block">
        <input  type="text" id="title" name="title" required layui_search=""  autocomplete="off" value="${(list.title)!""}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">简介</label>
      <div class="layui-input-block">
        <textarea placeholder="请输入简介"  id="digest" name="digest" autocomplete="off"
                          class="layui-textarea" style="height: 80px;">${(list.digest)!""}</textarea>
      </div>
    </div>

    <div class="layui-form-item">
      <label for="title" class="layui-form-label">更多</label>
      <div class="layui-input-block">
        <input  type="text" id="jump_url" name="jump_url" required layui_search="" autocomplete="off" value="${(list.jump_url)!""}" class="layui-input">
      </div>
    </div>

    <#include "../public/upload.ftl"/>

    <div class="layui-form-item layui-form-text">
      <label for="content" class="layui-form-label">产品内容</label>
      <div class="layui-input-block" >
        <script id="editor" type="text/plain" name="content"></script>
      </div>
    </div>


    <div class="layui-form-item">
      <label class="layui-form-label">多图片上传</label>
      <div class="layui-upload">
        <button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
        <button type="button" class="layui-btn" style="margin-left:150px;" id="testListAction">开始上传</button>
        <div class="layui-upload-list">
          <table class="layui-table">
            <thead>
            <tr>
              <th>文件名</th>
              <th>预览</th>
              <th>大小</th>
              <th>状态</th>
              <th>操作</th>
            </tr>
            </thead>
            <tbody id="demoList">
            <#if arr_image??>
              <#list arr_image as v>
              <tr>
                <td>${(v.file_name)!""}</td>
                <td><img src='${(v.file_path)!""}'></td>
                <td>${(v.file_size)!0}kb</td>
                <td><span style="color: #5FB878;">上传成功</span></td>
                <td>
                  <a class="layui-btn layui-btn-xs layui-btn-danger demo-delete" onclick="image_del(${v.fid})">删除</a>
                </td>
              </tr>
              </#list>
            </#if>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <div class="layui-form-item">
      <label for="sort" class="layui-form-label">排序</label>
      <div class="layui-input-block">
        <input type="text" class="layui-input" name="sort" value="${(list.sort)!1}">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">是否启用</label>
      <div class="layui-input-block">
        <select name="record_status" id="record_status">
          <#if (list??)>
            <option value="1" <#if (list.record_status ==1) >selected="selected"</#if>>启用</option>
            <option value="2" <#if (list.record_status ==2) >selected="selected"</#if>>禁用</option>
          <#else>
            <option value="1">启用</option>
            <option value="2">禁用</option>
          </#if>
        </select>
      </div>
    </div>

    <input type="hidden" name="fid" value="${(list.fid)!0}">
    <input type="hidden" name="data_images"  id="data_images" value="${(list.data_images)!""}">
    <div class="layui-form-item">
      <label class="layui-form-label"></label>
      <button class="layui-btn"  type="submit">保存</button>
    </div>
  </form>
</div>
<script>
  //重新渲染表单
  function renderForm(){
    layui.use('form', function(){
      var form = layui.form;
      form.render('select');
    });
  }

  $(document).ready(function(){

    /*加载分类*/
    var class_type =${(list.class_type)!0};
    publics(class_type);

    /*文本编辑*/
    var ue = UE.getEditor('editor');
    var field = '${(list.content)!""}';
    ue.addListener("ready", function () {
      // editor准备好之后才可以使用
      if (field != "") {
        ue.setContent(field);
      }
    });

    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function(action) {
      if (action === 'uploadimage' || action === 'uploadscrawl' || action === 'uploadimage') {
        //在这里返回我们实际的上传图片地址
        return '/api/imgUpdate';
      } else {
        return this._bkGetActionUrl.call(this, action);
      }
    };  ``

  });

  /*下拉框动态加载*/
  layui.use(['jquery','form','layer','table'], function(){
    var $ = layui.jquery;
    var form = layui.form;
    form.on('select(class_type)', function(data){
      publics(data.value);
    });
  });

  function publics(type){
    var class_id=${(list.class_id)!0};
    type=parseInt(type);
    var types=type===0 || type===1?2:3;
    $.ajax({
      url:'/product/gettype',
      data:{class_type:types},
      type:'post',
      success:function(data){
        //往下拉菜单里添加元素
        var option = '';
        $.each(data,function(index,item){
          //循环获取返回值，并组装成html代码
          var select="";
          var html=types===2?"产品-":"案例-";
          //console.log(item.fid,class_id,item.fid===class_id);
          if(item.fid===class_id){
            select=' selected="selected" ';
          }
          option +="<option value='"+item.fid+"' "+select+">"+html+item.class_name_zh+"</option>";
      });
      $('#nt').html("");
      $('#nt').append(option);
      renderForm();
      }
    });
  }
</script>
<script>
  layui.use('upload',function(){
    var $ = layui.jquery
            ,upload = layui.upload;
    //多文件列表示例
    var demoListView = $('#demoList')
            ,uploadListIns = upload.render({
      elem: '#testList'
      ,url: '/api/upload'
      ,accept: 'file'
      ,multiple: true
      ,data: {images_id:0}
      ,exts: 'jpg|png|gif|jpeg'
      ,size: 1024
      ,acceptMime: 'image/*'
      ,auto: false
      ,bindAction: '#testListAction'
      ,choose: function(obj){
        var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
        //读取本地文件
        obj.preview(function(index, file, result){
          var tr = $(['<tr id="upload-'+ index +'">'
            ,'<td>'+ file.name +'</td>'
            ,'<td><img src='+ result +'></td>'
            ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
            ,'<td>等待上传</td>'
            ,'<td>'
            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
            ,'</td>'
            ,'</tr>'].join(''));

          //单个重传
          tr.find('.demo-reload').on('click', function(){
            obj.upload(index, file);
          });

          //删除
          tr.find('.demo-delete').on('click', function(){
            delete files[index]; //删除对应的文件
            tr.remove();
            uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
          });

          demoListView.append(tr);
        });
      }
      ,done: function(res, index, upload){
        if(res.code == 200){ //上传成功
          var data_images=$("#data_images").val();
          if(data_images){
            var html=','+res.data;
          }else{
            var html=res.data;
          }
          $("#data_images").val(data_images +html);
          var tr = demoListView.find('tr#upload-'+ index)
                  ,tds = tr.children();
          tds.eq(3).html('<span style="color: #5FB878;">上传成功</span>');
          tds.eq(4).html('<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'); //清空操作
          return delete this.files[index]; //删除文件队列已经上传成功的文件
        }
        this.error(index, upload);
      }
      ,error: function(index, upload){
        var tr = demoListView.find('tr#upload-'+ index)
                ,tds = tr.children();
        tds.eq(3).html('<span style="color: #FF5722;">上传失败</span>');
        tds.eq(4).find('.demo-reload').removeClass('layui-hide'); //显示重传
      }
    });
  });
</script>

<script>
  //发异步删除数据
  function image_del(fid){
    var id='${(list.fid)!0}';
    $.ajax({
      type: "post",
      url: "/product/del_source",
      data: {image_ids:fid,type:-1,fid:id},
      dataType: "json",
      success: function (data) {
        if (data===1) {
          layer.msg("删除成功", {icon: 1, time: 500});
        } else {
          layer.msg("删除失败", {icon: 1, time: 500});
        }
        setTimeout(function () {
          window.location.href = "/product/edit?fid="+id;
        }, 500);
      }
    });
  }
</script>
</body>
</html>