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
<script>

var orderList = new Array();
var client = new Object();
$(document).ready(function(){
	
	var clientId = null;
	if(window.location.href.indexOf("?") > 0 ){
		var equalPos = window.location.href.indexOf("=");
		if(equalPos > 0){
			clientId = window.location.href.substr(equalPos + 1);
		}
	}
	
	//console.log("clientId = " + clientId);
	
	if(clientId != null) {
		initClientOrderInfoList(clientId);
	}else{
		initAllOrderTable();
	}
	
	$('#pp').pagination({
		onSelectPage:function(pageNumber, pageSize){
			updateOrderTable(orderList, pageNumber, pageSize);
		}
	});
});

function initAllOrderTable(){
	$.ajax({
    	dataType: "json",  
        type: "POST",
		url : '/order/list2.do',
		success : function(data) {
		
			 if ((data == null) || (data.length == 0)) { 
			     console.log("没有商品数据！");
			     return;
		     }
			 updateOrderList(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 console.log("fail");
		}
	});
}

function initClientOrderInfoList(clientId){
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientId": clientId
		},
		url : '/order/getOrderListByClientId.do',
		success : function(data) {
			if ((data == null) || (data.length == 0)) { 
				 console.log("该商家没有订单");
				 return;
			 } 
			 updateOrderList(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	});
	
	//console.log("商家信息 clientID = " + clientId)
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientId": clientId
		},
		url : '/client/getClientById.do',
		success : function(data) {
			if (data == null){
				console.log("该商家没有信息");
				return;
			}
			client = data;
			var textstr = "";
			if(client.name != null ){
				textstr = textstr + client.name + '/';
				if(client.telephone != null) {
					textstr = textstr + client.telephone;
				}
			}
			document.getElementById("title").value= textstr;
			document.getElementById("title").style.color = '#708090';
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	});
}

function addRow(){
	window.open("/order/toAdd2");
}

function deleteRows(){
    var che = document.getElementsByName("ordercheckbox");  
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
		url : '/order/deleteOrders.do',
		success : function(data) {
			
			 window.location.reload();
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
			 window.location.reload();
		}
	});
    
}

function updateOrderList(data){
	orderList.length = 0;
	orderList = data.slice(0);
	
	updateOrderTable(orderList, 1, 10);
}

function updateOrderTable(orderList, pageNo, pageSize){
	 if(orderList == null){
		 return;
	 }
	 
	 $("orderlist").html("");
	 var tbodyhtmlod = '';

	 for(var i= (pageNo - 1)*pageSize; (i< pageNo*pageSize) && (i < orderList.length); i++){
		 tbodyhtmlod += '<tr class="odd gradeX">';
		  tbodyhtmlod += '<td> <input id="' + orderList[i].id + '" class="odd gradeX" type="checkbox" name="ordercheckbox" '
		      + 'style="visibility: visible" onclick="ordersclickcheck(this)"> </td>';
		  tbodyhtmlod += '<td> ' + orderList[i].id   + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].clientName + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].clientChineseName + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].status + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].paymentTime + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].consignTime   + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].receiverMobile   + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].receiverAreaName + '</td>';
		  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
		      '<a href="<%=basePath%>/order/Edit2.jsp?id=' + orderList[i].id + '">查看订单&nbsp;&nbsp;&nbsp;</a>';
		  tbodyhtmlod += '<a href="<%=basePath%>/order/Edit2.jsp?id=' + orderList[i].id + '">修改订单</a> </td> </tr>';
	 }

	 console.log(tbodyhtmlod);
	 $("#orderlist").html(tbodyhtmlod);
	 
	 $('#pp').pagination({
		 total:orderList.length,
		 pageSize:10,
		 pageNumber:pageNo,
	});
}

function getOrderByClienteName(){	
	console.log("clientName = " + $("#title").val());
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientName": $("#title").val()
		},
		url : '/order/getOrderListByClientName.do',
		success : function(data) {
			 if (data == null){
				 console.log("该商家没有订单");
				 return;
			 } 
			 updateOrderList(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	});
}

function allcheck() {
	var allche = document.getElementById("selall");  
    var che = document.getElementsByName("ordercheckbox");  
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
     
function  editRow(obj){
    var i = 1;
	console.log(i);
	return;	 
}


</script>
 
<body class="easyui-layout">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
		<li><a href="javascript:void(0);">首页</a></li>
		<li><a href="javascript:void(0);">商家管理</a></li>
		<li><a href="javascript:void(0);">商家订单</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<div class="tools">
		<ul class="seachform">
		<li><label>商家名称</label><input id ="title" name="title" type="text" class="scinput" /> </li>
		<li><label>&nbsp;</label><input name="" type="button" onclick="getOrderByClienteName();" class="scbtn" value="查询"/></li>
		</ul>
		<ul class="toolbar">
		</ul>
		<ul class="toolbar1">
		</ul>
		</div>
	</div>
	
	<div class="tools">
		<ul class="toolbar">
	        <button type="button" class="btn btn-default" title="删除"  onclick="deleteRows()"><i class="fa fa-trash-o"></i> 删除</button>
	        <button type="button" class="btn btn-default" title="刷新" onclick="window.location.reload();"><i class="fa fa-refresh"></i> 刷新</button>
		</ul>
	</div>
	
	<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
		<div title="<span class='tt-inner'>商家列表<br></span>" style="padding:10px">
			<table class="table table-border table-bordered table-hover table-bg">
				<thead>
					<tr class="text-c">
						 <th style="width: 1%">
			                 <input id="selall" onclick="allcheck()" type="checkbox"/>
			             </th>
						<th style="width: 5%">订单号</th>
						<th style="width: 10%">商家名称</th>
						<th style="width: 10%">中文名称</th>
						<th style="width: 10%">订单状态</th>
						<th style="width: 15%">付款时间</th>
						<th style="width: 15%">发货时间</th>
						<th style="width: 10%">收货人手机</th>
						<th style="width: 10%">收货人地址</th>
						<th style="width: 15%">操作</th>
					</tr>
				</thead>
				<tbody id = "orderlist" >
									
			   </tbody>
			</table>
			<span><div class="easyui-pagination" data-options="total:20" id="pp" style="width:80%;margin-left:40px;"></div></span>
		</div>
	</div>
</body>

</html>