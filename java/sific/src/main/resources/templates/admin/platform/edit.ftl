<#include "../public/header.ftl"/>
<body>
<div class="x-body layui-anim layui-anim-up">
  <form class="layui-form" action="/platform/update" method="post" enctype="multipart/form-data">

    <div class="layui-form-item">
      <div class="layui-input-block">
        <script id="editor" type="text/plain" name="${field!''}" required></script>
      </div>
    </div>
    <input type="hidden" name="fid" value="${fid!0}">
    <div class="layui-form-item">
      <label class="layui-form-label"></label>
      <button class="layui-btn" lay-filter="save" lay-submit="" type="submit">保存</button>
    </div>
  </form>
</div>
<script>
  /*文本编辑*/
  var ue = UE.getEditor('editor');
  var field = '${(result)!""}';
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