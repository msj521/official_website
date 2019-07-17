<#include "../public/header.ftl"/>
<body>
<div class="x-body">
  <form action="/user/feedback_update" method="post">

    <div class="layui-form-item">
      <label class="layui-form-label">用户名</label>
      <div class="layui-input-block">
        <input  type="text" id="user_name" name="user_name"  disabled autocomplete="off" value="${(list.user_name)!""}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">联系电话</label>
      <div class="layui-input-block">
        <input  type="text" id="tel" name="tel" disabled autocomplete="off" value="${(list.tel)!""}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">公司名称</label>
      <div class="layui-input-block">
        <input  type="text" id="company" name="company" disabled autocomplete="off" value="${(list.company)!""}" class="layui-input">
      </div>
    </div>


    <div class="layui-form-item layui-form-text">
      <label for="content" class="layui-form-label">反馈内容</label>
      <div class="layui-input-block" >
        <script id="editor"  type="text/plain" name="content"></script>
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">处理备注</label>
      <div class="layui-input-block">
        <textarea placeholder="处理备注"  id="remark" name="remark" autocomplete="off"
                          class="layui-textarea" style="height: 80px;">${(list.remark)!""}</textarea>
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">处理状态</label>
      <div class="layui-input-block">
        <select name="solution_state" id="solution_state">
          <#if (list??)>
            <option value="1" <#if (list.solution_state ==1) >selected="selected"</#if>>待处理</option>
            <option value="2" <#if (list.solution_state ==2) >selected="selected"</#if>>处理中</option>
            <option value="3" <#if (list.solution_state ==3) >selected="selected"</#if>>已处理</option>
          <#else>
            <option value="1">待处理</option>
            <option value="2">处理中</option>
            <option value="3">已处理</option>
          </#if>
        </select>
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
</script>
</body>
</html>