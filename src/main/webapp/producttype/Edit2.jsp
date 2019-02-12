<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
	    <base href="<%=basePath%>">
	    <title>查看商品类型</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
    </head> 
  
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css" />
	<link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="../css/style.css">
	
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script src="../static/jquery-3.3.1.min.js" type="text/javascript"></script>

    <style>
    .a-upload {
        padding: 4px 10px;
        width: 100px;
        height: 25px;
        line-height: 20px;
        position: relative;
        cursor: pointer;
        color: #FFFFFF;
        background: #4682B4;
        border: 1px solid #ddd;
        border-radius: 4px;
        overflow: hidden;
        display: inline-block;
        *display: inline;
        *zoom: 1
    }

    .a-upload  input {
        position: absolute;
        font-size: 100px;
        right: 0;
        top: 0;
        opacity: 0;
        filter: alpha(opacity=0);
        cursor: pointer
    }

    .a-upload:hover {
        color: #444;
        background: #eee;
        border-color: #ccc;
        text-decoration: none
    }
    
</style>

<script type="text/javascript">


var categoryid = null;
$(document).ready(function () {
	if(window.location.href.indexOf("?") > 0 ){
		var equalPos = window.location.href.indexOf("=");
		if(equalPos > 0){
			categoryid = window.location.href.substr(equalPos + 1);
		}
	}
	
	
	
});



</script>
  
<body  class="easyui-layout" style="width:100%;height:100%;">	
	<div data-options="region:'east',split:false" title="east" style="width:180px;"></div>
	<div data-options="region:'west',split:false" title="west" style="width:100px;"></div>
	<div data-options="region:'south',split:false" title="south" style="height:100px;"></div>
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:590px;z-index:1">
	    
			 <div class="place">
				<span>位置：</span>
				<ul class="placeul">
				<li><a href="javascript:void(0);">首页</a></li>
				<li><a href="javascript:void(0);">商品管理</a></li>
				<li><a href="javascript:void(0);">查看商品类型</a></li>
				</ul>
			</div>
			<br />
		<div class="box-body" style="text-align:center; align-items:center; ">	
			<form id="ff" method="post">	
			   <label id="id" for="名称"  >名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="name" value = "${producttype.name}" name="name"><br></br>
			   
			   <br></br>
			   
			   <div>
			      <label for="图片">图片</label><br></br>
			      <tr>	
				       <td>
				      		<img alt="" id="typeimage" src="${producttype.picture}" width="100px" height="100px">	            	 
				       </td>
				        
				   </tr>
			   <div>	 
			   <br></br>
			   <label for="商品类型介绍">商品类型介绍&nbsp;</label><input class="easyui-textbox" id="remarks" value = "${producttype.remarks}" name="remarks"  style="width:150px;"><br></br>
			   
		   </form>
		       
	  </div>
  </div>  	
</body>

</html>
