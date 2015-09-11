<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>ANTO-TDL</title>
<link href="../style/style.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery.js" type="text/javascript" ></script>
<script src="../js/jquery.easing.1.3.js" type="text/javascript" ></script>
<script type="text/javascript" src="/js/pages.js"></script>
<link type="text/css" rel="stylesheet" href="/style/pages.css"/>
{literal}
<script>
$(document).ready(function(e) {
	//默认加载页头
	$(".top_bar").stop(false,false).delay(400).animate({"top":"0px"},600,'easeOutBounce');
	$("#show_box").stop(false,false).delay(1000).fadeIn(500,function(){
		$("#page_box").stop(true,true).fadeIn(1500);
	});
	//默认第一页
    change_page(1,"n_ing");
	//navi点击
	$(".nav_li").each(function(){
		$(this).click(function(){
			$(".nav_li").removeClass('nav_click');
			$(this).addClass('nav_click');
			var ss_type = $(this).attr('id');
			change_page(1,ss_type);
			$("#cc_ss_type").html(ss_type);
		})
	})
	//shadow,取消按钮点击取消面板
	$("#shadow,.inner_close").click(function(){
		cancel_panel();
	})
	//新建+点击
	$("#add_btn").click(function(){
		//取消所有
		cancel_panel();
		$("#shadow").show(0,function(){
			$("#add_panel").show();
		});
	})
	//新建任务
	$("#add_task").click(function(){
		var task=$("#task").val();
		var aim=$("#aim").val();
		var need=$("#need").val();
		if(task=="" || aim=="" || need==""){
			alert("请填写完整！")
			return false;
		}else{
			$("#addtsk_form").submit();
		}
	})
});
//取消所有
function cancel_panel(){
	$("#shadow,#add_panel,#change_panel").hide();
}
//修改任务
function change_task(e){
	//取消所有
	cancel_panel();
	$("#shadow").show(0,function(){
		$("#change_panel").show();
	});
	$.ajax({
		type:"GET",
			url:"index.php",
			data:"search_id="+e,
			dataType:"json",
			success:function(data){
				$.each(data,function(index,json){
					$("#c_id").val(json.id);
					$("#c_task").val(json.task);
					$("#c_aim").val(json.aim);
					$("#c_need").val(json.need);
					$("#c_weight").val(json.weight);
					$("#c_other").val(json.other);
				})
			}
		})
}
//分页
$(function(){
	var all_num = $("#all_num").html();
    $(".page_bar").pagination({
        items: all_num,
        itemsOnPage: 20,
        cssStyle: 'light-theme'
    });
});
function cut(all_num){
    $(".page_bar").pagination({
        items: all_num,
        itemsOnPage: 20,
        cssStyle: 'light-theme'
    });
}
function change_page(to_page,ss_type){
	$("#now_page").html(to_page);
	$.ajax({
			type:"GET",
			url:"index.php",
			data:"change_page="+ss_type+"&to_page="+to_page,
			dataType:"json",
			success:function(data){
				//alert(data)
				$("#page_data").empty();
				var html = "";
				$.each(data,function(index,json){
					html += '<tr class="mouse_hover"><td>'+json.id+'</td><td><div style="width:200px;overflow:hidden;text-overflow:ellipsis;cursor:pointer;" class="task_name" onclick="change_task(\''+json.id+'\')">'+json.task+'</div></td><td><div style="width:60px;overflow:hidden;text-overflow:ellipsis;">'+json.aim+'</div></td><td>'+json.weight+'</td><td>'+json.need+'</td><td><div style="width:100px;overflow:hidden;text-overflow:ellipsis;">'+json.file+'</div></td><td>'+json.t_start+'</td><td>'+json.over+'</td><td>'+json.ok+'</td><td><div style="width:100px;overflow:hidden;text-overflow:ellipsis;">'+json.other+'</div></td><td><div style="width:260px;overflow:hidden;text-overflow:ellipsis;">'+json.who+'</div></td></tr>';
				})
				html = '<tr class="title_bg"><td style="width:26px;">ID</td><td>TO DO LIST</td><td>目的</td><td style="width:20px;">权重</td><td style="width:50px;">需求方</td><td>需求文档</td><td style="width:78px;">启动时间</td><td style="width:78px;">申请提交</td><td style="width:78px;">审核通过</td><td>备注</td><td>执行方</td></tr>'+html;
				$("#page_data").html(html);
				$("#page_data tr:even").css('background','#eee'); //表格变色
            },
			error: function(){
              //请求出错处理
                  alert("Error!");
            }
	})
	$.ajax({
		url:"index.php",
		type:"GET",
		data:"all_num&to_page="+to_page+"&ss_type="+ss_type,
			success:function(data){
					$("#all_num").html(data);	//返回总数
					cut(data);
            }
	})
}
</script>
{/literal}
</head>

<body>
<div id="shadow"></div>
<div class="top_bar">
<div class="f_left logo_bar">
	<div class="f_left"><img src="../images/anto.jpg" height="50" /></div><div class="f_right">上海安藤国际贸易有限公司</div>
    <div class="clear"></div>
</div>
<div class="f_right txt_bar"><b>TO DO LIST </b><span style="font-size:10px;">v3.0</span>&nbsp;ღ&nbsp;<i style="font-size:12px;"> Powered by ycmbcd </i>&nbsp;&nbsp;</div>
<div class="clear"></div>
</div>
<div id="show_box" style="height:760px;display:none;">
<ul id="nav">
    <li class="nav_click nav_li" id="n_ing">进行中</li>
    <li id="n_not" class="nav_li">未审核</li>
    <li id="n_all" class="nav_li">ALL</li>
    <li id="add_btn" style="background:none;border:none;width:25px;"><img src="/images/add.png" /></li>
    <li id="user_btn" style="background:none;border:none;width:25px;"><img src="/images/users.png" /></li>
    <div class="clear"></div>
</ul>
<table class="s_table" id="page_data">
</table>
<div id="page_box">
    <div id="cc_ss_type">n_ing</div>
    <div id="now_page">1</div>
    <div class="page_bar f_right"></div>
    <div id="num_box" class="f_right">合计：<span id="all_num"></span></div>
    <div class="clear"></div>
</div>
</div>
<!--add_panel-->
<form id="addtsk_form" method="post" enctype="multipart/form-data">
<div id="add_panel">
	<div class="inner_close"></div>
	<ul style="margin:30px 0 0 30px;">
    	<li class="title_add">Task：</li>
        <li><input id="task" type="text" placeholder="必填.." name="task" style="width:400px;" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">目的：</li>
        <li><input id="aim" type="text" placeholder="必填.." name="aim" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">权重：</li>
        <li>
        	<select id="weight" name="weight" style="width:40px;">
  				<option>低</option>
  				<option>中</option>
  				<option>高</option>
			</select>
        </li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">需求方：</li>
        <li><input id="need" type="text" placeholder="必填.." name="need" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">需求文档：</li>
        <li><input style="width:160px;" type="file" name="file" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">执行方：</li>
        <li style="width:500px;">{foreach $resu as $se}
        	<label><div style="width:80px;float:left;font-size:16px;"><input type="checkbox" value="{$se.name}" name="who[]" /> {$se.name}</div></label> 
            {/foreach}
            <div class="clear"></div>
        </li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add"></li>
    	<li style="margin-top:47px;"><button class="btn" id="add_task" style="width:60px;">添&nbsp;加</button></li>
    </ul>
</div>
</form>
<!--change_panel-->
<form id="changetsk_form" method="post" enctype="multipart/form-data">
<div id="change_panel">
	<div class="inner_close"></div>
	<ul style="margin:30px 0 0 30px;">
    	<li class="title_add">Task：</li>
        <li>
        <input type="hidden" value="" id="c_id" name="c_id" />
        <input id="c_task" type="text" placeholder="必填.." name="c_task" style="width:400px;" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">目的：</li>
        <li><input id="c_aim" type="text" placeholder="必填.." name="c_aim" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">权重：</li>
        <li>
        	<select id="c_weight" name="c_weight" style="width:40px;">
  				<option>低</option>
  				<option>中</option>
  				<option>高</option>
			</select>
        </li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">需求方：</li>
        <li><input id="c_need" type="text" placeholder="必填.." name="c_need" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add">执行方：</li>
        <li style="width:500px;">{foreach $resu as $se}
        	<label><div style="width:80px;float:left;font-size:16px;"><input type="checkbox" value="{$se.name}" name="c_who[]" /> {$se.name}</div></label> 
            {/foreach}
            <div class="clear"></div>
        </li>
        <div class="clear"></div>
    </ul>
    <ul style="margin-top:47px;">
    	<li class="title_add">备注：</li>
        <li><input id="c_other" onClick="$(this).val('')" name="c_other" type="text" /></li>
        <div class="clear"></div>
    </ul>
    <ul>
    	<li class="title_add"></li>
    	<li style="margin-top:11px;"><button class="btn" onClick="$(this).submit()" style="width:60px;">修&nbsp;改</button>
        </li>
    </ul>
</div>
</form>
</body>
</html>