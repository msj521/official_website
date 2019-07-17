<?php
namespace app\admin\Controller;

use app\admin\common\Base;
use think\Db;
use think\Model;
use think\Request;


class Banner extends Base {

    /**
     * @var \think\Request Request实例
     */
     protected $request;
     protected $table;
     protected $table_two;
     protected $path;
     protected $return;
     protected $edit;
     protected $update;
     protected $del;
     protected function _initialize() {
        parent::_initialize();
        $this->path=$this->request->path();
        $this->title=get_menu_title(request()->path());
        $this->assign("title", $this->title);
        
        switch($this->path){
            /* 轮播图 */
             case "banner/index";
             case "banner/edit";
             case "banner/update";
             case "banner/del";
                $this->table="v_ad_banner";
                $this->table_two="ad_banner_info";
                $this->return="/banner/index";
                $this->edit="/banner/edit";
                $this->update="/banner/update";
                $this->del="/banner/del";
                $this->assign("title", "轮播列表");
                break;
            /* 广告位 */
             case "banner/adsense";
             case "banner/adsense_edit";
             case "banner/adsense_update";
             case "banner/adsense_del";
                $this->table="v_ad_adsense";
                $this->table_two="ad_adsense_info";
                $this->return="/banner/adsense";
                $this->edit="/banner/adsense_edit";
                $this->update="/banner/adsense_update";
                $this->del="/banner/adsense_del";
                $this->assign("title", "广告位");
                break;
        }

        $this->assign("index", $this->return);
        $this->assign("edit", $this->edit);
        $this->assign("update", $this->update);
        $this->assign("del", $this->del);
    }   
    /**
     * @return string|void
     * 推荐管理
     */
    public function Index() {
        $where = array();
        $string = '';
        $start = "";
        $end = "";
        $module = "";
        $location = "";
        $data = array_filter($_GET);
        if (!empty($data)) {
            $string = isset($data['string']) ? $data['string'] : "";

            $location = isset($data['location']) ? $data['location'] : "";
            if ($location) {
                $where["location"] = $location;
            }

            $module = isset($data['module']) ? $data['module'] : "";
            if ($module) {
                $where["module"] = $module;
            }

            if ($string) {
                $like = array('like', "%" . $string . "%");
                
                if($this->path=="banner/adsense"){
                    $where['title|url|user_name'] = $like;
                }else{
                    $where['title'] = $like;
                }
            }
        }
        $list = $this->sific_list($where,$this->table);
        $count = count($list);

        /*分类*/
        $Class = banner_type(-1);
        $this->assign("class", $Class);

        $this->assign("list",$list);
        $this->assign("start", $start);
        $this->assign("end", $end);
        $this->assign("location", $location);
        $this->assign("module", $module);

        return $this->fetch("$this->return", ['cnt' => $count, 'string' => $string]);
    }

    /**
     * 数据编辑
     */
    public function Edit() {
        $list = $this->sific_edit($this->table);
        $this->assign("list", $list);

        /*位置*/
        $banner_type = banner_type(-1);
        $this->assign("banner_type", $banner_type);

        /*页面级别*/
        $adsense_level = adsense_level(-1);
        $this->assign("adsense_level", $adsense_level);

        /*广告位*/
        $adsense_number = adsense_number(-1);
        $this->assign("adsense_number", $adsense_number);

        return $this->fetch("$this->edit");
    }

    /**
     * 数据添加 更新
     */
    public function Update() {

        if ($this->request->isPost()) {
            $data = $this->request->param(true);
            $main_id=isset($data['main_id'])?$data['main_id']:"";
            /* 跳转url处理 */
            if(isset($data['module']) && !empty($data['module']) && !empty($main_id)){
                $table="";
                if($data['module']==2){
                    $data['location_url']="/convention?convention_id=".$main_id;
                    $table="convention_info";
                }else if($data['module']==3){
                    $data['location_url']="/livesinfo?live_id=".$main_id;
                    $table="live_info";
                }else if($data['module']==4){
                    $data['location_url']="/videoinfo?training_id=".$main_id;
                    $table="product_info";
                }
                $one = DB::table($table)->where(['fid'=>$main_id,'record_status'=>1])->find();
                if(empty($one)){
                    $this->error("所属模块ID不存在！");
                }
            }

            if(isset($data['web_image_id']) && empty($data['web_image_id'])){
                $this->error("web必须上传");
            }elseif(isset($data['app_image_id']) && empty($data['app_image_id'])){
				$this->error("APP必须上传");
			}
            //var_dump($data,$this->table_two,$this->return);die;
            $status = $this->sific_update($data,$this->table_two);
            if ($status) {
                echo "<script>var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);parent.window.location.href='$this->return';</script>";
                exit;
            } else {
                $this->error("表单提交失败~~1");
            }
        } else {
            $this->error("表单提交失败~~2");
        }
    }

    /**
     * 数据删除
     */
    public function Delete() {
        $data = $this->request->param(true);
        $status = $this->sific_delete($data,$this->table_two);
        if ($status) {
            $data_status = ["code" => "1", "msg" => "删除成功"];
        } else {
            $data_status = ["code" => "0", "msg" => "删除失败"];
        }
        return $data_status;
    }

}
