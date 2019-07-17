<div class="layui-form-item">
  <label class="layui-form-label">图片上传</label>
    <div class="layui-upload">
      <div style="float: left; width: 150px; text-align: center;">
         <button type="button" class="layui-btn" id="img">图片上传</button>
        <div class="layui-upload-list">
          <img class="layui-upload-img" id="img1" width="450" src="${(list.file_path)!""}">
        </div>
      </div>
    </div>
</div>
<input type="hidden"  name="images_id"  id="FImageUrl" value="${(list.images_id)!0}">
<script>
  layui.use('upload',function(){
      var $ = layui.jquery
      ,upload = layui.upload;
      var web_image_id='${(list.images_id)!0}';

      if(web_image_id<0){
          $(".layui-upload-list").attr("style","display:none");
      }
        //WEB图片上传
      upload.render({
        elem: '#img'
        ,url: '/api/upload'
        ,data: {images_id:web_image_id}
        ,acceptMime: 'image/*'
        ,exts: 'jpg|jpeg|gif|bmp|png'
        ,before: function(obj){
          obj.preview(function(index, file, result){
            $('#img1').attr('src', result);
          });
        }
        ,done: function(res){
          //如果上传失败
          if(res.code === "200"){
            $('#FImageUrl').attr('value', res.data);
            return layer.msg('上传成功');
          }else{
            return layer.msg('上传失败');
          }
        }
      });
});
</script>