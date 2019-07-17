<#include "../public/header.ftl"/>
<body class="login-bg">
    <div class="login layui-anim layui-anim-up">
        <div class="message">康尔泰管理登录</div>
        <div id="darkbannerwrap"></div>
        <form method="post" class="layui-form">
            <input name="tel" placeholder="手机号"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
    </div>

<script>
 layui.use('form', function(){
  var form = layui.form
  ,jq = layui.jquery;
    form.on('submit(login)', function (data) {
    $.ajax({
        type: 'POST',
        url: "/loginVerify",
        data: data.field,
        async: true,
        success: function (result) {
            if (result.code==="200") {
                layer.msg(result.msg, {icon: 1, time: 1000});
                setTimeout(function () {
                    self.location ='/admins';
                }, 800);
            }else if (result.code==="403") {
                layer.msg(result.msg, {icon: 2, time: 1000});
                setTimeout(function () {
                    self.location ='/admins';
                }, 800);
            }else {
                layer.msg(result.msg, {icon: 2, time: 1000});
                setTimeout(function () {
                    self.location ='/login';
                }, 800);
            }
        } 
    });
      return false;
    });
  })       
</script>
</body>
</html>