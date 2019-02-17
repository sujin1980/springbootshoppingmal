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

var goodsList = new Array();

$(function(){	
	initGoodsTable();
	
	$('#pp').pagination({
		onSelectPage:function(pageNumber, pageSize){
			updateGoodsTable(goodsList, pageNumber, pageSize);
		}
	});
});

function initGoodsTable(){
	$.ajax({
    	dataType: "json",  
        type: "POST",
		url : '/product/list2.do',
		success : function(data) {
			 if (data == null) {  
			     alert("没有商品数据！");
			     return;
		     }
			 updateGoodsList(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}

function updateGoodsList(data){
	goodsList.length = 0;
	goodsList = data.slice(0);
	
	console.log(data);
	console.log(goodsList);
	updateGoodsTable(goodsList, 1, 10);
}

function updateGoodsTable(goodsList, pageNo, pageSize){
	 if(goodsList == null){
		 return;
	 }
	
	 $("productlist").html("");
	 var tbodyhtmlod = '';

	 for(var i= (pageNo - 1)*pageSize; (i< pageNo*pageSize) && (i < goodsList.length); i++){
		  
		  
		  tbodyhtmlod += '<tr class="odd gradeX">';
		  tbodyhtmlod += '<td> <input id="' + goodsList[i].id + '" class="odd gradeX" type="checkbox" name="goodscheckbox" '
		      + 'style="visibility: visible" onclick="goodsclickcheck(this)"> </td>';
		  tbodyhtmlod += '<td> ' + goodsList[i].id   + '</td>';
		  tbodyhtmlod += '<td> ' + goodsList[i].name + '</td>';
		  tbodyhtmlod += '<td> ' + goodsList[i].productType.name + '</td>';
		  tbodyhtmlod += '<td> ' + goodsList[i].productType.productCategory.name + '</td>';
		  tbodyhtmlod += '<td> ' + goodsList[i].price   + '</td>';
		  tbodyhtmlod += '<td> ' + goodsList[i].remarks + '</td>';
		  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
		      '<a href="<%=basePath%>/product/show?id=' + goodsList[i].id + '">查看&nbsp;&nbsp;</a> ';
		  tbodyhtmlod += '<a href="<%=basePath%>/product/toEdit2?id=' + goodsList[i].id + '">修改&nbsp;&nbsp;</a>';    
		  tbodyhtmlod += '<a href="javascript:void(0);"  onclick="addProducToOrder(' + goodsList[i].id + ')">加入订单</a></td> </tr>';
	 }

	 //console.log(tbodyhtmlod);
	 $("#productlist").html(tbodyhtmlod);
	 $('#pp').pagination({
		 total:goodsList.length,
		 pageSize:10,
		 pageNumber:pageNo,
	});
}

function getProductByName(){
	var strid = ""; 
	
	var val = $("#name").val();
	if(val.indexOf("=") > 0){
		strid = val.substring(0, val.indexOf("="));
	}else{
		strid = val;
	}
	
	$.ajax({
	   dataType: "json",  
       type: "POST",
		data: {
			"name": strid
		},
		url : '/product/getproductbyname.do',
		success : function(data) {
			 if (data != null) {  
				 updateGoodsList(data); 
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	return;
}

function addRow(){
	//window.open("/product/toAdd2");
	window.location.href = "/product/toAdd2";
}

function deleteRows(){
    var che = document.getElementsByName("goodscheckbox");  
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
		url : '/product/deleteProducts.do',
		success : function(data) {
			 if(data == "OK"){
				 window.location.reload();
			 }else{
				 alert("ok");
			 }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			//alert("fail");
			window.location.reload();
		}
	});
    
}

function allcheck() {
	var allche = document.getElementById("selall");  
    var che = document.getElementsByName("goodscheckbox");  
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
   
 function goodsclickcheck(obj) {
	if(obj.checked==false){  
        var allche = document.getElementById("selall");  
        allche.checked = false;
    }
}



function addProducToOrder(productid){
	if(('${sessionScope.clientorder.clientName}' == '') || ('${sessionScope.clientorder.id}' == '')
	       	 && ('${sessionScope.clientorder.status}' == '')){
		alert("商家名称或订单为空，不能添加商品到订单。请至先至商家处添加或修改订单！");
		return;
	}
	
	
	alert("prodcutid = " + productid);
	$.ajax({
		type: "POST",
	    async: true,
		data: {
			"id": productid
		},
		url : '/ordergoods/addProducToOrder.do',
		success : function(data) {
			 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	return;
}

</script>
 
<body class="easyui-layout">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
		<li><a href="javascript:void(0);">首页</a></li>
		<li><a href="javascript:void(0);">商品管理</a></li>
		<li><a href="javascript:void(0);">商品列表</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<div class="tools">
		<ul class="seachform">
		<li><label>商品名称</label><input id="name" name="name" type="text" class="scinput" /></li>
		
		<li><label>&nbsp;</label><input name="" type="button" onclick="getProductByName();" class="scbtn" value="查询"/></li>
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
	    <div title="<span class='tt-inner'>商品列表<br></span>" style="padding:10px">
			<table class="table table-border table-bordered table-hover table-bg">
			<thead>
				<tr class="text-c">
				    <th style="width: 1%">
	                    <input id="selall" onclick="allcheck()" type="checkbox"/>
	                </th>
					<th style="width: 5%">商品ID</th>
					<th style="width: 15%">名称</th>
					<th style="width: 15%">一级分类</th>
					<th style="width: 15%">二级分类</th>
					<th style="width: 15%">商品价格</th>
					<th style="width: 10%">描述</th>
					<th style="width: 10%">明细</th>
				</tr>
			</thead>
			<tbody id="productlist">
								
		   </tbody>
		</table>
		<span><div class="easyui-pagination" id="pp" style="width:80%;margin-left:40px;"></div></span>
	</div>
	    
	</div>
	
	
</body>

</html>