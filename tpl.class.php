<?php
	#Smarty通用配置文件
	require('./smarty/Smarty.class.php');
	$smarty = new Smarty();
	$smarty->left_delimiter = "{";
	$smarty->right_delimiter = "}";
	$smarty->template_dir = "tpl";
	$smarty->compile_dir = "template_c";
	$smarty->caching = false;
	$smarty->cache_dir = "cache";
	$smarty->cache_lifetime = 0;
?>