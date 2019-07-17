<#include "../public/header.ftl"/>
<body>
<div class="x-body">
  <form action="/item/update" method="post" enctype="multipart/form-data" >
    <div class="layui-form-item">
      <label class="layui-form-label">名称</label>
      <div class="layui-input-block">
        <input  type="text" id="class_name_zh" name="class_name_zh" required layui_search=""  autocomplete="off" value="${(list.class_name_zh)!""}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">跳转路由</label>
      <div class="layui-input-block">
        <input  type="text" id="jump_url" name="jump_url"  autocomplete="off" value="${(list.jump_url)!""}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label class="layui-form-label">所属分类</label>
      <div class="layui-input-block">
        <select name="class_type" id="class_type">
          <#if (location_list??)>
            <#list location_list as v>
              <option value="${v_index+1}"
                      <#if (list??) >
                        <#if (v_index+1==list.class_type) >selected</#if>
                      </#if>
              >${v}</option>
            </#list>
          <#else>
          </#if>
        </select>
      </div>
    </div>

    <#include "../public/upload.ftl"/>

    <div class="layui-form-item layui-form-text">
      <label for="description" class="layui-form-label">备注</label>
      <div class="layui-input-block" >
        <textarea placeholder="请输入备注"  id="remark" name="remark" autocomplete="off"
                              class="layui-textarea" style="height: 80px;">${(list.remark)!""}</textarea>
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
    <input type="hidden" name="fid" value="${(list.fid)!''}">
    <div class="layui-form-item">
      <label class="layui-form-label"></label>
      <button class="layui-btn"  type="submit">保存</button>
    </div>
  </form>
</div>
</body>
</html>