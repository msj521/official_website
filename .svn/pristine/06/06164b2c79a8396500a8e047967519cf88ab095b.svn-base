<?php
namespace app\admin\controller;

use app\admin\common\Base;
use think\Db;
use think\Model;
use think\Request;

class Product extends Base {

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
            /* 产品列表 */
             case "product/index";
             case "product/edit";
             case "product/update";
             case "product/del";
                $this->table="v_product";
                $this->table_two="product_info";
                $this->return="/product/index";
                $this->edit="/product/edit";
                $this->update="/product/update";
                $this->del="/product/del";
                break;         
            /* 产品打包 */
             case "product/parge";
             case "product/update";
                $this->table="v_product";
                $this->table_two="product_info";
                $this->return="/product/index";
                $this->edit="/product/parge";
                $this->update="/product/update";
                break;         
            case "product/order";
            case "product/order_del";
            case "product/order_edit";
            case "product/order_update";
                $this->table="v_product_order";
                $this->table_two="product_order_info";
                $this->return="/product/order";
                $this->edit="/product/order_edit";
                $this->del="/product/order_del";
                $this->update="/product/order_update";
                break; 
             case "product/section";
             case "product/section_edit";
             case "product/section_update";
             case "product/section_del";
                $this->table="v_product_section";
                $this->table_two="product_section_info";
                $this->return="/product/section";
                $this->edit="/product/section_edit";
                $this->update="/product/section_update";
                $this->del="/product/section_del";
                break;        
             case "product/collect";
             case "product/collect_edit";
             case "product/collect_update";
             case "product/collect_del";
                $this->table="v_product_collect";
                $this->table_two="product_collect_info";
                $this->return="/product/collect";
                $this->edit="/product/collect_edit";
                $this->update="/product/collect_update";
                $this->del="/product/collect_del";
                break;    
        }

        $this->assign("index", $this->return);
        $this->assign("edit", $this->edit);
        $this->assign("update", $this->update);
        $this->assign("del", $this->del);
     }
    /**
     * @return string|void
     * 列表
     */
    public function Index() {
        $where = array();
        //parent::initIndex($request,$where);
        $string = '';
        $data = array_filter($_GET);
        if (!empty($data)) {
            $string = isset($data['string']) ? trim($data['string']) : "";
			$key = table_key($this->table);
			if(!empty($key) && $string){
				$like = array('like', "%" . $string . "%");
				$where[$key] = $like;
			}
/*             if ($string) {
                $like = array('like', "%" . $string . "%");
                switch($this->path){
                     case "product/index";
                        $where['product_name|description']=$like;
                        break;         
                    case "product/order";
                        $where['product_name|user_name']=$like;
                        break; 
                     case "product/section";
                        $where['product_name|title']=$like;
                        break;      
                     case "product/collect";
                        $where['product_name|user_name']=$like;
                        break;   
                }
            } */
        }

        $fid=isset($data['fid'])?$data['fid']:0;
        if($this->table=="v_product_section" && $fid>0){
            $where['product_id']=$fid;
        }

        $list = $this->sific_list($where,$this->table);
        $count = count($list);
        $this->assign("list", $list);
        $this->assign("fid", $fid);

        /*分类*/
        $Class = classify(1006);
        $this->assign("class", $Class);


        return $this->fetch("$this->return", ['cnt' => $count, 'string' => $string]);
    }

    /**
     * 产品编辑
     */
    public function Edit() {
        $param = $this->request->param(true);
        $fid=isset($param['fid'])?$param['fid']:0;
        $product_id=isset($param['product_id'])?$param['product_id']:0;

        if($this->table=="v_product_section" && $product_id && !$fid){
            $where['fid']=$product_id;
            $list = Db::table("v_product")
                    ->where($where)
                    ->find();
        }else{
            $list = $this->sific_edit($this->table);
        }
        
        if(!empty($list) && isset($list['web_image_id']) || isset($list['app_image_id'])){
            $list['image_url'] =SourceInfo($list['web_image_id'],1);
            $list['image_urls'] =SourceInfo($list['app_image_id'],1);
        }

        $this->assign("fid", $fid);
        $this->assign("product_id", $product_id);
        $this->assign("list", $list);
        
        /*直播分类*/
        $live_class =classify(5);
        $this->assign("live_class", $live_class);
        
        /* 录播分类 */
        $video_class =classify(6);
        $this->assign("video_class", $video_class);

        /*产品打包类型*/
        $product_type =product_type(-1);
        $this->assign("product_type", $product_type);


        /* 产品明细列表 */
        $select_list=[];
        if(!empty($list) && $fid>0){
            if ($list['product_type']==2) {
                $product_video=Db::table("v_product_video")
                        ->where(['product_id'=>$fid,'main_type'=>2])
                        ->order('sort',"desc")
                        ->select();

                $product_exam=Db::table("v_product_exam")
                        ->where(['product_id'=>$fid,'main_type'=>3])
                        ->order('sort',"desc")
                        ->select();
                $select_list=array_merge($product_video,$product_exam);
            }else{
                $select_list=Db::table("v_product_live")
                        ->where(['product_id'=>$fid,'main_type'=>1])
                        ->order('sort',"desc")
                        ->select();
            }
        }
    
        $this->assign("select_list", json_encode($select_list));

        /*直播列表 */
        $live_list=Db::table("v_live")
                        ->where(['record_status'=>1])
                        ->order('fid',"desc")
                        ->select();
        $this->assign("live_list",$live_list);

       /*录播列表 */
        $video_list=Db::table("v_video")
                        ->where(['record_status'=>1])
                        ->order('fid',"desc")
                        ->select();
        $this->assign("video_list",$video_list);

        /* 章节列表 */
        $product_section=Db::table("v_product_section")
                        ->order('fid',"desc")
                        ->where(['product_id'=>$fid])
                        ->select();
        $this->assign("product_section",$product_section);

        /* 考试列表 */
        $product_exam=Db::table("exam_info")
                        ->order('fid',"desc")
                        ->select();
        $this->assign("product_exam",$product_exam);

        if($this->table=="v_product_order"){
            //产品列表-新增购买记录使用
            $product_list=Db::table("product_info")
                        ->order('fid',"desc")
                        ->where(['record_status'=>1])
                        ->select();
            $this->assign("product_list",$product_list);
            //用户列表-新增购买记录使用
            $user_list=Db::table("enduser_info")
                        ->order('fid',"desc")
                        ->where(['record_status'=>1])
                        ->select();
            $this->assign("user_list",$user_list);
        }
        return $this->fetch("$this->edit");
    }



    public function Update() {

        if ($this->request->isPost()) {
            $data = $this->request->param(true);
           //var_dump($data);die;
            $expert_ids =isset($data['fids']) ? json_decode(htmlspecialchars_decode($data['fids']),true) :[];
            $fid=isset($data['fid'])?$data['fid']:0;

            $b=0;
            if ($this->table_two=="product_info" && isset($data['product_name'])) {
                $b=NoRepetition($fid,['product_name'=>trim($data['product_name'])],$this->table_two);
            }
    
            if($b>0){
                $this->error('名称已存在！');
            }
            
            if(isset($data['web_image_id']) && empty($data['web_image_id'])){
                $this->error("web必须上传");
            }elseif(isset($data['app_image_id']) && empty($data['app_image_id'])){
				$this->error("APP必须上传");
			}
			
            $product_type=isset($data['product_type'])?$data['product_type']:0;
            $expert_id=[];
			
            /*添加产品明细之前删除相关明细 再进行添加*/
            if($this->table_two=="product_info" && isset($data['fids'])){
                $arr= [];
                foreach ($expert_ids as $key => $value) {
                    if(!isset($value['main_id'])) continue;
                    $arr[]=$value['main_id'];
                }

                $data['main_id']=implode(",",$arr);                 
                Db::table('product_detail_info') 
                            ->where('product_id',$fid)
                            //->whereNotIn('main_id',$data['main_id'])
                            ->delete();
                if($product_type==1){
                    $expert_id=Db::table('v_live_expert')
                            ->whereIn('live_id',$data['main_id'])
                            ->column('expert_id');
                }else if($product_type==2){
                    $expert_id=Db::table('v_video_expert')
                            ->whereIn('video_id',$data['main_id'])
                            ->column('expert_id');
                            
                }
            }
            //echo Db::table("v_video_expert")->getLastSql();
            /* 主表更新 */
			//var_dump(implode(",",$expert_id),$expert_ids,$arr);die;
            $data['expert_id']=implode(",",$expert_id);
            $status = $this->sific_update($data,$this->table_two);

            if ($status) {
                //产品明细处理
                Db::startTrans();
                try {
                    if (count($expert_ids)>0) {
                        foreach ($expert_ids as $key => $value) {
                            $tmp = [];
                            $tmp = HandleParamsForInsert('product_detail_info',$value);
                            if(isset($value['main_type'])){
                                if($tmp['main_type']=="直播"){
                                    $tmp['main_type']=1;
                                }else if($tmp['main_type']=="录播"){
                                    $tmp['main_type']=2;
                                }else if($tmp['main_type']=="考试"){
                                    $tmp['main_type']=3;
                                }
                            }
/*                             if(isset($value['fid'])){
                                $tmp['updater_id']=fid?fid:1;
                                Db::table('product_detail_info')->where(['fid'=>$value['fid']])->setField($tmp);
                            }else{ */
                                $tmp['creator_id'] =fid?fid:1;
                                $tmp['create_time'] =date("Y-m-d H:i:s",time());
                                $tmp['product_id'] =$fid?$fid:$status;
                                Db::table("product_detail_info")->insertGetId($tmp);
              /*               } */
                            //echo Db::table("product_detail_info")->getLastSql();
                        }
                    }
                }catch (\Exception $e) {
                    echo $e->getMessage();
                    $this->error("表单提交失败~~".$e->getMessage());
                }
                Db::commit();

                $product_id=isset($data['product_id'])?$data['product_id']:0;
                $location="$this->return";
                if($this->table_two=="product_section_info"){
                    $location="$this->return?fid=$product_id";
                }
                
                echo "<script>var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);parent.window.location.href='$location';</script>";
                exit;
            } else {
                $this->error("表单提交失败~~1");
            }
        } else {
            $this->error("表单提交失败~~2");
        }
    }

    /**
     * 产品管理 | 基础资料删除
     */
    public function Delete() {
        $data = $this->request->param(true);
        $fid=isset($data['fid'])?$data['fid']:'';
        $status = $this->sific_delete($data,$this->table_two);
        //产品删除同时删除相关字表数据
        
        if(isset($status['code']) && $status['code']==1 && !empty($fid) && $data['type']==-2){
            Db::startTrans();
            try {
 
                if($this->table_two=="product_info"){
                    $where=['product_id'=>$fid];
                    //产品-明细表
                    $this->sondel($where,"product_detail_info");
                    //产品-培训章节表
                    $this->sondel($where,"product_section_info");
                    //产品收藏
                    $this->sondel($where,"product_collect_info");
                }

            }catch (\Exception $e) {
                echo $e->getMessage();
                $this->error("删除失败~~".$e->getMessage());
            }
            Db::commit();
        }
        return $status;
    }

    function sondel($where,$table){
        Db::table("$table")->where($where)->delete();
    }

}
