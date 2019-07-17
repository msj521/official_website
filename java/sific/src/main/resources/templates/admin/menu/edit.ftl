<#include "../public/header.ftl"/>
<body>
<div class="x-body">
  <form class="" action="/menu/update" method="post" enctype="multipart/form-data" >
      <div class="layui-form-item">
        <label class="layui-form-label">菜单名称</label>
        <div class="layui-input-block">
          <input  type="text" id="menu_name" name="menu_name" required layui_search=""  autocomplete="off" value="${(list.menu_name)!""}" class="layui-input">
        </div>
      </div>

      <div class="layui-form-item">
        <label for="route" class="layui-form-label">路由地址</label>
        <div class="layui-input-block">
          <input  type="text" id="route" name="route" required layui_search="" autocomplete="off" value="${(list.route)!""}" class="layui-input">
        </div>
      </div>

      <div class="layui-form-item">
        <label class="layui-form-label">是否启用</label>
        <div class="layui-input-block">
          <select name="record_status" id="record_status">
              <#if (list??)>
                  <option value="1" <#if (list.record_status =="1") >selected="selected"</#if>>启用</option>
                  <option value="2" <#if (list.record_status =="2") >selected="selected"</#if>>禁用</option>
              <#else>
                  <option value="1" >启用</option>
                  <option value="2" >禁用</option>
              </#if>
          </select>
        </div>
      </div>
      <input type="hidden" name="fid" value="${(list.fid)!0}">

    <div class="layui-form-item">
      <label class="layui-form-label"></label>
      <button class="layui-btn" layui_filter="save" layui_submit="" type="submit">保存</button>
    </div>
  </form>
</div>
</body>
</html>