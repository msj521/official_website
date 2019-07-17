{include file="public/header" /}
<body>
<div class="x-body layui-anim layui-anim-up">
  <form class="layui-form" action="{$update|default='/'}" method="post" enctype="multipart/form-data">

    <div class="layui-form-item">
      <label for="title" class="layui-form-label">标题<?php html_sign();?></label>
      <div class="layui-input-block">
        <input type="text" id="title" name="title"  lay-verify="required" autocomplete="off" value="{$list.title|default=''}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label for="title" class="layui-form-label">来源<?php html_sign();?></label>
      <div class="layui-input-block">
        <input type="text" id="source" name="source"  lay-verify="required" autocomplete="off" value="{$list.source|default=''}" class="layui-input">
      </div>
    </div>

    <div class="layui-form-item">
      <label for="url" class="layui-form-label">跳转URL<?php html_sign();?></label>
      <div class="layui-input-block">
        <input type="text" id="url" name="url"  lay-verify="required" autocomplete="off" value="{$list.url|default=''}" class="layui-input">
      </div>
    </div>   
    
    <div class="layui-form-item">
        <label class="layui-form-label xbs768">所属模块<?php html_sign();?></label>
        <div class="layui-input-block">
          <select name="module" lay-verify="required" lay-search="" >
            <option value="">直接选择或搜索选择</option>
            {volist name="banner_type" key="ko" id="vo"}
            <option value="{$ko}"  {if condition="$ko eq $list.module"} selected="selected" {/if} >{$vo}</option>
            {/volist}
          </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label xbs768">页面级别<?php html_sign();?></label>
        <div class="layui-input-block">
          <select name="level" lay-verify="required" lay-search="" >
            <option value="">直接选择或搜索选择</option>
            {volist name="adsense_level" key="ko" id="vo"}
            <option value="{$ko}"  {if condition="$ko eq $list.level"} selected="selected" {/if} >{$vo}</option>
            {/volist}
          </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label xbs768">广告位<?php html_sign();?></label>
        <div class="layui-input-block">
          <select name="number_id" lay-verify="required" lay-search="" >
            <option value="">直接选择或搜索选择</option>
            {volist name="adsense_number" key="ko" id="vo"}
            <option value="{$ko}"  {if condition="$ko eq $list.level"} selected="selected" {/if} >{$vo}</option>
            {/volist}
          </select>
        </div>
    </div>
            
    <div class="layui-form-item">
        <label for="sort" class="layui-form-label">排序</label>
        <div class="layui-input-block" >
            <input type="number" name="sort" lay-verify="required" class="layui-input" value="{$list.sort|default=''}">
        </div>
    </div>

    {include file="public/upload" /}
    <input type="hidden" name="fid" value="{$list.fid|default=''}">

    <div class="layui-form-item">
      <label class="layui-form-label xbs768">状态</label>
      <div class="layui-input-block">
        <input type="radio" name="record_status" value="1" title="启用" checked>

        <input type="radio" name="record_status" value="2" title="禁用" {if condition="isset($list['record_status']) && $list['record_status'] eq 2"} checked {/if}>
        <input type="radio" name="record_status" value="2" title="标记删除" {if condition="isset($list['record_status']) &&  $list['record_status'] eq -1"} checked {/if}>
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label"></label>
      <button class="layui-btn" lay-filter="save" lay-submit="" type="submit">保存</button>
    </div>
  </form>
</div>
<script>
</script>
</body>
</html>