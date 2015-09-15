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
			$(".alert_txt").html("请填写完整！");
			$("#red_alert_panel").fadeIn(300).delay(1500).fadeOut(300);
			return false;
		}else{
			$("#addtsk_form").submit();
		}
	})
    //人员管理
    $("#user_btn").click(function(){
        //取消所有
        cancel_panel();
        $("#shadow").show(0,function(){
            $("#people_panel").show()
        });
    })
});
//取消所有
function cancel_panel(){
	$("#shadow,#add_panel,#change_panel,#people_panel,#over_panel,#ok_panel").hide();
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
					html += '<tr class="mouse_hover"><td>'+json.id+'</td><td><div style="width:200px;overflow:hidden;text-overflow:ellipsis;cursor:pointer;" class="show_cmplt task_name" onclick="change_task(\''+json.id+'\')">'+json.task+'</div></td><td><div style="width:60px;overflow:hidden;text-overflow:ellipsis;">'+json.aim+'</div></td><td>'+json.weight+'</td><td>'+json.need+'</td><td><a href="/uploads/'+json.file+'"><div style="width:100px;overflow:hidden;text-overflow:ellipsis;" class="show_cmplt">'+json.file+'</div></a></td><td>'+json.t_start+'</td><td class="can_over" onclick="show_over(\''+json.id+'\')">'+json.over+'</td><td class="can_ok" onclick="show_ok(\''+json.id+'\')">'+json.ok+'</td><td><div style="width:100px;overflow:hidden;text-overflow:ellipsis;">'+json.other+'</div></td><td><div class="show_cmplt" style="width:260px;overflow:hidden;text-overflow:ellipsis;">'+json.who+'</div></td></tr>';
				})
				html = '<tr class="title_bg"><td style="width:26px;">ID</td><td>TO DO LIST</td><td>目的</td><td style="width:20px;">权重</td><td style="width:50px;">需求方</td><td>需求文档</td><td style="width:78px;">启动时间</td><td style="width:78px;">申请提交</td><td style="width:78px;">审核通过</td><td>备注</td><td>执行方</td></tr>'+html;
				$("#page_data").html(html);
				$("#page_data tr:even").css('background','#eee'); //表格变色
				//show_cmplt
				$(".show_cmplt").each(function(){
					$(this).hover(function(){
						var ss=$(this).html();
						$("#show_cmplt").html(ss);
					},function(){
						$("#show_cmplt").html("");
					})	
				})
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
//人员添加
function add_people(){
	var ss=$("#add_people").val()
	$.ajax({
		url:"index.php",
		type:"POST",
		data:"add_people="+ss,
			success:function(data){
				if(data=="ok"){
					//取消所有
	        		cancel_panel();
					$(".alert_txt").html("添加成功！");
					$("#green_alert_panel").fadeIn(300).delay(1500).fadeOut(300,function(){
	        			window.location='index.php';
					});
				}
            }
	})
}
//人员删除
function del_people(){
	var ss=$("#del_people").val()
	$.ajax({
		url:"index.php",
		type:"POST",
		data:"del_people="+ss,
			success:function(data){
				if(data=="ok"){
					//取消所有
	        		cancel_panel();
					$(".alert_txt").html("删除成功！");
					$("#red_alert_panel").fadeIn(300).delay(1500).fadeOut(300,function(){
	        			window.location='index.php';
					});
				}
            }
	})
}
//show over
function show_over(e){
	//取消所有
    cancel_panel();
    $("#shadow").show(0,function(){
		$("#over_panel").show();
		$("#over_id").html(e);
	});
}
//show ok
function show_ok(e){
	//取消所有
    cancel_panel();
    $("#shadow").show(0,function(){
		$("#ok_panel").show();
		$("#ok_id").html(e);
	});
}
//任务提交
function can_over(){
	var ss=$("#over_id").html()
	$.ajax({
		url:"index.php",
		type:"POST",
		data:"can_over="+ss,
			success:function(data){
				if(data=="ok"){
					//取消所有
	        		cancel_panel();
					$(".alert_txt").html("任务完成！");
					$("#green_alert_panel").fadeIn(300).delay(1500).fadeOut(300,function(){
	        			var ss_type=$("#cc_ss_type").html();
						var now_page=$("#now_page").html();
	        			change_page(now_page,ss_type);
					});
				}
            }
	})
}
//任务审核
function can_ok(){
	var ss=$("#ok_id").html()
	$.ajax({
		url:"index.php",
		type:"POST",
		data:"can_ok="+ss,
			success:function(data){
				if(data=="ok"){
					//取消所有
	        		cancel_panel();
					$(".alert_txt").html("审核成功！");
					$("#green_alert_panel").fadeIn(300).delay(1500).fadeOut(300,function(){
						var ss_type=$("#cc_ss_type").html();
						var now_page=$("#now_page").html();
	        			change_page(now_page,ss_type);
					});
				}
            }
	})
}
</script>
{/literal}
</head>