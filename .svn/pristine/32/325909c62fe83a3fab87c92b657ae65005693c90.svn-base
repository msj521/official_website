<#include "../public/header.ftl"/>
<body>
<div class="x-body">
  <form action="/banner/update" method="post" enctype="multipart/form-data" >
      <div class="layui-form-item">
        <label class="layui-form-label">标题</label>
        <div class="layui-input-block">
          <input  type="text" id="title" name="title" required layui_search=""  autocomplete="off" value="${(list.title)!""}" class="layui-input">
        </div>
      </div>

      <div class="layui-form-item">
        <label class="layui-form-label">轮播位置</label>
        <div class="layui-input-block">
          <select name="location" id="location">
            <#if (location_list??)>
              <#list location_list as v>
                <option value="${v_index+1}"
                        <#if (list??) >
                          <#if (v_index+1==list.location) >selected</#if>
                        </#if>
                >${v}</option>
              </#list>
            <#else>

            </#if>
          </select>
        </div>
      </div>

      <#include "../public/upload.ftl"/>

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
            <option value="1" <#if (list.record_status =="1") >selected="selected"</#if>>启用</option>
            <option value="2" <#if (list.record_status =="2") >selected="selected"</#if>>禁用</option>
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
</body>
</html>