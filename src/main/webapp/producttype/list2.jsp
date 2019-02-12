<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>欢迎登录后台管理系统</title>
		<meta http-equiv="pragma" content="no-cache">
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
	
<script type="text/javascript">

var typeList = new Array();

var categoryName = "易耗品";
var categoryid = "4";

$(function(){	
	initTypeTable("4");
	
	$('#pp').pagination({
		onSelectPage:function(pageNumber, pageSize){
			updateTypeTable(typeList, pageNumber, pageSize);
		}
	});
});

function initTypeTable(id){
	categoryid = id;
	$.ajax({
    	dataType: "json",  
        type: "POST",
        data:{
            "categoryid": categoryid	
        },
		url : '/producttype/getTypeListByCategoryId.do',
		success : function(data) {
			 //alert("ok");
			 if (data == null) {  
			     alert("没有类型数据！");
			     return;
		     }
			 updateTyeList(data, categoryid); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}

function updateTyeList(data, categoryid){
	typeList.length = 0;
	typeList = data.slice(0);
	
	console.log(data);
	console.log(typeList);

	if(categoryid == "4"){
		categoryName = "易耗品";
		$('#type1').css("color","#DC143C");
		$('#type2').css("color","#000000");
		$('#type3').css("color","#000000");
	}else if(categoryid == "2"){
		categoryName = "有偿用品";
		$('#type1').css("color","#000000");
		$('#type2').css("color","#DC143C");
		$('#type3').css("color","#000000");
	}else{
		categoryName = "布草";
		$('#type1').css("color","#000000");
		$('#type2').css("color","#000000");
		$('#type3').css("color","#DC143C");
	}
	updateTypeTable(typeList, 1, 10);
}

function updateTypeTable(typeList, pageNo, pageSize){
	 if(typeList == null){
		 return;
	 }
	
	 $("goodstypelist").html("");
	 var tbodyhtmlod = '';

	 for(var i= (pageNo - 1)*pageSize; (i< pageNo*pageSize) && (i < typeList.length); i++){
		  
		  
		  tbodyhtmlod += '<tr class="odd gradeX">';
		  tbodyhtmlod += '<td> <input id=' + typeList[i].id + 'class="odd gradeX" type="checkbox" name="typecheckbox" '
		      + 'style="visibility: visible" onclick="typeclickcheck(this)"> </td>';
		  tbodyhtmlod += '<td> ' + typeList[i].id   + '</td>';
		  tbodyhtmlod += '<td> ' + typeList[i].name + '</td>';
		  tbodyhtmlod += '<td> ' + typeList[i].picture   + '</td>';
		  tbodyhtmlod += '<td> ' + typeList[i].remarks + '</td>';
		  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
		      '<a href="<%=basePath%>/producttype/toEdit2?id=' + typeList[i].id + '">查看</a> ';
		  tbodyhtmlod += '<a href="<%=basePath%>/producttype/toEdit2?id=' + typeList[i].id + '">修改</a></td> </tr>';
	 }

	 console.log(tbodyhtmlod);
	
	 $("#goodstypelist").html(tbodyhtmlod);
	 $('#pp').pagination({
		 total:typeList.length,
		 pageSize:10,
		 pageNumber:pageNo,
	});
	//document.getElementById ("typetile").title ="易耗品";
	
	var tab = $('#tt').tabs('getSelected'); 
	$('#tt').tabs('update', {
		tab: tab,
		options: {
			title: categoryName
		}
	});
	return;
}

function getTypeByName(){
	var strid = ""; 
	
	var val = $("#name").val();
	if(val.indexOf("=") > 0){
		strid = val.substring(0, val.indexOf("="));
	}else{
		strid = val;
	}
	
	if(categoryName == "易耗品"){
		categoryid = "4";
	}else if(categoryName == "有偿用品"){
		categoryid = "2";
	}else{
		categoryid = "3";
	}
	$.ajax({
   	dataType: "json",  
       type: "POST",
		data: {
			"name": strid
		},
		url : '/producttype/getTypeByName.do',
		success : function(data) {
			 alert("ok");
			 if (data != null) {  
				 updateTyeList(data, categoryid); 
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	return;
}

function deleteRows(){
    var che = document.getElementsByName("typecheckbox");  
    var idlist = {};
    
    for(var i=0; i < che.length;i++){  
        if(che[i].checked == true){
        	idlist[i] = che[i].id;
        }
    }  
    
    $.ajax({
    	dataType: "json",  
        type: "POST",
		data: idlist,
		url : '/producttype/deleteProductTypes.do',
		success : function(data) {
			 //alert("ok");
			 if (data != null) {
				 window.location.reload();
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
    
}

function allcheck() {
	var allche = document.getElementById("selall");  
    var che = document.getElementsByName("typecheckbox");  
    if(allche.checked == true){  
        for(var i=0;i<che.length;i++){  
            che[i].checked="checked";  
        }  
    }else{  
        for(var i=0;i<che.length;i++){  
            che[i].checked=false;  
        }  
    }  
 }
   
function typeclickcheck(obj) {
	if(obj.checked==false){  
        var allche = document.getElementById("selall");  
        allche.checked = false;
    }
}

function addRow(){
    window.location.href = "/producttype/Add2.jsp?categoryid=" + categoryid;
    return;
}

</script>
 
<body class="easyui-layout">
	<div class="place">
		<div style="display:inline;">
			<span>位置：</span>
			<ul class="placeul">
				<li><a href="javascript:void(0);">首页</a></li>
				<li><a href="javascript:void(0);">商品管理</a></li>
				<li><a href="javascript:void(0);">商品类型</a></li>
			</ul>
		</div> 
		<div style="display:table-cell;padding-left:50px;padding-top:15px;vertical-align:middle;text-align:center;margin:0 auto;">
			<nav>
				<a href="javascript:void(0);" onclick='initTypeTable("4")' id = "type1" class="shopping-client-text" >易耗品</a>&nbsp;&nbsp;&nbsp; 
				<a href="javascript:void(0);" onclick='initTypeTable("2")' id = "type2" class="shopping-client-text" >有偿用品</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);" onclick='initTypeTable("3")' id = "type3" class="shopping-client-text" >布草</a>
			</nav>
		</div> 
	</div>

		
	<div class="rightinfo">
		<div class="tools">
		<ul class="seachform">
		<li><label>类型名称</label><input id="name" name="name" type="text" class="scinput" /></li>
		
		<li><label>&nbsp;</label><input name="" type="button" onclick="getTypeByName()" class="scbtn" value="查询"/></li>
		</ul>
		<ul class="toolbar">
		</ul>
		<ul class="toolbar1">
		</ul>
		</div>
	</div>
	<div class="tools">
		<ul class="toolbar">
			<button type="button" class="btn btn-default" title="新建"  onclick="addRow()" ><i class="fa fa-file-o"></i> 新建</button>
	        <button type="button" class="btn btn-default" title="删除"  onclick="deleteRows()"><i class="fa fa-trash-o"></i> 删除</button>
	        <button type="button" class="btn btn-default" title="刷新"  onclick="window.location.reload();"><i class="fa fa-refresh"></i> 刷新</button>
		</ul>
	</div>
	
	<div id="tt" class="easyui-tabs"  data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
	    <div id="typetile" style="padding:10px">
			<table class="table table-border table-bordered table-hover table-bg">
			<thead>
				<tr class="text-c">
				    <th style="width: 1%">
	                    <input id="selall" onclick="allcheck()" type="checkbox"/>
	                </th>
					<th style="width: 5%">类型ID</th>
					<th style="width: 15%">名称</th>
					<th style="width: 15%">图片</th>
					<th style="width: 10%">描述</th>
					<th style="width: 10%">明细</th>
				</tr>
			</thead>
			<tbody id="goodstypelist">
					
		   </tbody>
		</table>
		<span><div class="easyui-pagination" id="pp" style="width:80%;margin-left:40px;"></div></span>
	</div>

</body>

</html>