{include file="head.tpl"}
<body>
<div id="shadow"></div>
<div id="show_cmplt"></div>
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
    <li id="n_ok" class="nav_li">已完成</li>
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
    	<li style="margin-top:47px;"><button class="btn green_btn" id="add_task" style="width:60px;">添&nbsp;加</button></li>
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
    	<li style="margin-top:11px;"><button class="btn blue_btn" onClick="$(this).submit()" style="width:60px;">修&nbsp;改</button>
        </li>
    </ul>
</div>
</form>
<!--people_panel-->
<div id="people_panel">
    <div class="inner_close"></div>
    <div class="title_panel">职员管理</div>
    <div class="row_panel">
        <input id="add_people" style="width:80px;height:22px;margin-top: 1px;" type="text" />
        <button class="btn green_btn ml10 f_right" style="width:60px;" onclick="add_people()">添&nbsp;加</button>
        <div class="clear"></div>
    </div>
    <div class="row_panel">
        <select id="del_people" style="height:26px;width:88px;margin-top: 1px;">
            {foreach $resu as $se}
            <option value="{$se.id}">{$se.name}</option>
            {/foreach}
        </select>
        <button class="btn red_btn ml10 f_right" style="width:60px;" onclick="del_people()">删&nbsp;除</button>
        <div class="clear"></div>
    </div>
</div>
<!--over_panel-->
<div id="over_panel">
    <div class="inner_close"></div>
    <div class="title_panel" style="margin:36px 0;">你确定做完了【<span id="over_id"></span>】号任务？</div>
    <div class="row_panel">
        <button class="btn green_btn ml10 f_left" style="width:60px;" onclick="can_over()">是&nbsp;的</button>
        <button class="btn red_btn ml10 f_right" style="width:60px;" onclick="cancel_panel()">取&nbsp;消</button>
        <div class="clear"></div>
    </div>
</div>
<!--ok_panel-->
<div id="ok_panel">
    <div class="inner_close"></div>
    <div class="title_panel" style="margin:36px 0;">【<span id="ok_id"></span>】号任务通过审核？</div>
    <div class="row_panel">
        <button class="btn green_btn ml10 f_left" style="width:60px;" onclick="can_ok()">是&nbsp;的</button>
        <button class="btn red_btn ml10 f_right" style="width:60px;" onclick="cancel_panel()">取&nbsp;消</button>
        <div class="clear"></div>
    </div>
</div>
<!--alert_panel-->
<div id="green_alert_panel">
    <div class="alert_txt">000</div>
</div>
<div id="red_alert_panel">
    <div class="alert_txt">000</div>
</div>
</body>
</html>