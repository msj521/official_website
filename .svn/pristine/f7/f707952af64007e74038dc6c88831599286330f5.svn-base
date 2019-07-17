<#include "../public/header.ftl"/>
<body>
<div class="x-body">
  <form action="/news/update" method="post" enctype="multipart/form-data" >
    <div class="layui-form-item">
      <label class="layui-form-label">新闻名称</label>
      <div class="layui-input-block">
        <input  type="text" id="title" name="title" required layui_search=""  autocomplete="off" value="${(list.title)!""}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">所属分类</label>
      <div class="layui-input-block">
        <select name="class_id" id="class_id">
          <#if (new_class??)>
            <#list new_class as v>
              <option value="${v.fid!0}"
                      <#if (list??) >
                        <#if (v.fid==list.class_id) >selected</#if>
                      </#if>
              >${v.class_name_zh!""}</option>
            </#list>
          <#else>
          </#if>
        </select>
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">简介</label>
      <div class="layui-input-block">
        <input  type="text" id="digest" name="digest"  autocomplete="off" value="${(list.digest)!""}" class="layui-input">
      </div>
    </div>

    <#include "../public/upload.ftl"/>

    <div class="layui-form-item layui-form-text">
      <label for="content" class="layui-form-label">新闻内容</label>
      <div class="layui-input-block" >
        <script id="editor" type="text/plain" name="content"></script>
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

    <div class="layui-form-item">
      <label class="layui-form-label"></label>
      <button class="layui-btn"  type="submit">保存</button>
    </div>
  </form>
</div>
<script>
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
  };
</script>
</body>
</html>