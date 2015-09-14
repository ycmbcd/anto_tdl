<?php
	require_once("tpl.class.php");
	require_once("db.php");
//查询人员
	$db=new DB();
	$sql="select * from people order by id desc;";
	$res=$db->execute($sql);
	$smarty->assign("resu",$res);
//分页搜索+切换分类
	if(isset($_GET['change_page'])){
		$ss_type = $_GET['change_page'];
		$eve_num = 20;//每页20个
		$to_page = $_GET['to_page'];
		$start = $to_page*$eve_num-$eve_num; 
 		$end = $eve_num;
 		$db = new DB();
 		if($ss_type=="n_ing"){
 			$sql = "select *,from_unixtime(t_start,'%Y-%m-%d')as t_start from tdl where over='进行中...' order by id desc limit {$start},{$end};";
 		}else if($ss_type=="n_not"){
 			$sql = "select *,from_unixtime(t_start,'%Y-%m-%d')as t_start from tdl where over<>'进行中...' and ok='未审核' order by id desc limit {$start},{$end};";
 		}else if($ss_type=="n_all"){
 			$sql = "select *,from_unixtime(t_start,'%Y-%m-%d')as t_start from tdl order by id desc limit {$start},{$end};";
 		}else if($ss_type=="n_ok"){
 			$sql = "select *,from_unixtime(t_start,'%Y-%m-%d')as t_start from tdl where ok<>'未审核' order by id desc limit {$start},{$end};";
 		}
 		$res = $db->execute($sql);
		echo json_encode($res);
		return false;
	}
//返回总数
	if(isset($_GET['all_num'])){
		$ss_type = $_GET['ss_type'];
		$to_page = $_GET['to_page'];
 		$db = new DB();
 		if($ss_type=="n_ing"){
 			$sql = "select count(1) from tdl where over='进行中...';";
 		}else if($ss_type=="n_not"){
 			$sql = "select count(1) from tdl where over<>'进行中...' and ok='未审核';";
 		}else if($ss_type=="n_all"){
 			$sql = "select count(1) from tdl;";
 		}else if($ss_type=="n_ok"){
 			$sql = "select count(1) from tdl where ok<>'未审核';";
 		}
		$res = $db->execute($sql);
		foreach ($res as $value); 
		$all_num = $value['count(1)'];
		echo $all_num;
		return false;
	}
//增加任务
if(isset($_POST['task'])){
	$m_task=$_POST['task'];
	$m_aim=$_POST['aim'];
	$m_weight=$_POST['weight'];
	$m_need=$_POST['need'];
	@$m_who=implode(" | ",$_POST['who']);
	$m_t_start=time();
	$m_over="进行中...";
	$m_ok="未审核";
	$m_other="-";
//文件上传
 if ($_FILES['file']['error'] > 0) 
    {echo "***** 没有上传文件 *****";}
 try
 {
    if($_FILES['file']['size']>500000000)
      {
       $goodtogo=false;
       throw new exception("对不起，您上传的文件大小为".intval($_FILES['file']['size']/1000)."KB。超过限制大小");
      }
 }
 catch(exception $e)
    {
     echo $e->getmessage();
     ?> 
     <br/><a href="Javascript:history.back(-1)"><br/>重新上传<br/><br/></a>
     <?php
     return;
    }
//文件重命名之前保留文件名以备存在数据库中
 $strname= $_FILES['file']['name'];
//移动上传文件到uploads目录
	if(file_exists($strname )){
		echo "<br/>您上传文件的已经在本地保存过";
	}else{
	 move_uploaded_file($_FILES['file']['tmp_name'], "./uploads/".$strname);//移动文件到指定文件夹uploads；
	  "<br/>上传文件保存路径:"."./uploads/".$strname;  
	}  
	$m_file=$strname;
//添加到数据库
	$db=new DB();
	$sql="insert into tdl(task,aim,weight,need,file,who,t_start,over,ok,other) values ('$m_task','$m_aim','$m_weight','$m_need','$m_file','$m_who','$m_t_start','$m_over','$m_ok','$m_other');";
	$res=$db->execute($sql);
	echo "<script>alert('添加“{$m_task}”成功！');window.location='index.php';</script>";
	return false;
}	
//修改任务查询
	if(isset($_GET['search_id'])){
		$id = $_GET['search_id'];
 		$db = new DB();
		$sql = "select *,from_unixtime(t_start,'%Y-%m-%d')as t_start from tdl where id='{$id}';";
 		$res = $db->execute($sql);
		echo json_encode($res);
		return false;
	}
//修改任务
if(isset($_POST['c_task'])){
	$id=$_POST['c_id'];
	$task=$_POST['c_task'];
	$aim=$_POST['c_aim'];
	$weight=$_POST['c_weight'];
	$need=$_POST['c_need'];
	$who=implode(" | ",$_POST['c_who']);
	$other=$_POST['c_other'];
	$db=new DB();
	$sql="update tdl set task='$task',weight='$weight',need='$need',aim='$aim',who='$who',other='$other' where id='$id';";
	$res=$db->execute($sql);
	echo "<script>alert('修改成功！');window.location='index.php';</script>";
	return false;
}
//添加人员
if(isset($_POST['add_people'])){
	$new_people=$_POST['add_people'];
	$db=new DB();
	$sql="insert into people (name)values('{$new_people}');";
	$res=$db->execute($sql);
	echo "ok";
	return false;
}
//删除人员
if(isset($_POST['del_people'])){
	$people_id=$_POST['del_people'];
	$db=new DB();
	$sql="delete from people where id='{$people_id}';";
	$res=$db->execute($sql);
	echo "ok";
	return false;
}
//提交完成
if(isset($_POST['can_over'])){;
	$id=$_POST['can_over'];
	$new_time=date("Y-m-d", time());
	$db=new DB();
	$sql="update tdl set over='$new_time' where id='$id';";
	$res=$db->execute($sql);
	echo "ok";
	return false;
}
//审核完成
if(isset($_POST['can_ok'])){;
	$id=$_POST['can_ok'];
	$new_time=date("Y-m-d", time());
	$db=new DB();
	$sql="update tdl set ok='$new_time' where id='$id';";
	$res=$db->execute($sql);
	echo "ok";
	return false;
}
//Smarty
$smarty->display("index.tpl");
 
?>
