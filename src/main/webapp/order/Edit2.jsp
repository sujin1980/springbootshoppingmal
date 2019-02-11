<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

var orderList = new Array();

$(document).ready(function(){
	var _body = window.parent;
	var _iframe1 = _body.document.getElementById('topFrame');
	_iframe1.contentWindow.location.reload(true);
	
	var orderId = null;
	if(window.location.href.indexOf("?") > 0 ){
		var equalPos = window.location.href.indexOf("=");
		if(equalPos > 0){
			orderId = window.location.href.substr(equalPos + 1);
		}
	}
	
	//alert("orderId = " + orderId);
	initOrderTable(orderId);

	$('#pp').pagination({
		onSelectPage:function(pageNumber, pageSize){
			updateOrderTable(orderList, pageNumber, pageSize);
		}
	});
});

function initOrderTable(orderId){
	$.ajax({
    	dataType: "json",  
        type: "POST",
        data:{
        	"orderId": orderId
        },
		url : '/ordergoods/getOrderGoodsListByOrderId.do',
		success : function(data) {
			 //alert("ok");
			 if (data == null) {  
			     alert("没有商品数据！");
			     return;
		     }
			 updateOrderList(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	$.ajax({
    	dataType: "json",  
        type: "POST",
        data:{
        	"id": orderId
        },
		url : '/order/toEdit2.do',
		success : function(data) {
			 //alert("ok");
			 if (data == null) {  
			     alert("没有商品数据！");
			     return;
		     }
			 updateOrderInfo(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}

function updateOrderList(data){
	orderList.length = 0;
	orderList = data.slice(0);
	
	//console.log(data);
	//console.log(orderList);
	updateOrderTable(orderList, 1, 10);
}

function updateOrderTable(orderList, pageNo, pageSize){
	$("orderlist").html("");
	var tbodyhtmlod = '';

	for(var i= (pageNo - 1)*pageSize; (i< pageNo*pageSize) && (i < orderList.length); i++){
		 tbodyhtmlod += '<tr class="odd gradeX">';
		  tbodyhtmlod += '<td> <input id=' + orderList[i].goodsId + 'class="odd gradeX" type="checkbox" name="goodscheckbox" '
		      + 'style="visibility: visible" onclick="goodsclickcheck(this)"> </td>';
		  tbodyhtmlod += '<td> ' + orderList[i].goodsName   + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].price + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].goodsNumber + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].goodsFee + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].picture   + '</td>';
		  tbodyhtmlod += '<td> ' + orderList[i].remarks + '</td>';
		  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
		      '<a href="<%=basePath%>/product/toEdit2?id=' + orderList[i].goodsId + '">查看</a> ';
		  tbodyhtmlod += '<a href="javascript:void(0);" onclick="addGoodsNumber('+ orderList[i].goodsId + ');return false;">增加数量</a>'; 	  
		  tbodyhtmlod += '<a href="javascript:void(0);" onclick="decGoodsNumber('+ orderList[i].goodsId + ');return false;">减少数量</a></td> </tr>';
	 }

	 console.log(tbodyhtmlod);
	 $("#orderlist").html(tbodyhtmlod);
	 
	 $('#pp').pagination({
		 total:orderList.length,
		 pageSize:10,
		 pageNumber:pageNo,
	});
}

function updateOrderDateTimeInfo(data){
	var myDate = new Date().toLocaleString();
	
	if('${order.paymentTime}'.indexOf("未") >= 0){
		$('#paymentTime').datetimebox('setValue', myDate);
	}else{
		$('#paymentTime').datetimebox('setValue', data.paymentTime);
	}
	
	if('${order.consignTime}'.indexOf("未") >= 0){
		$('#consignTime').datetimebox('setValue', myDate);
	}else{
		$('#consignTime').datetimebox('setValue', data.consignTime);
	}
	
	if('${order.endTime}'.indexOf("未") >= 0){
		$('#endTime').datetimebox('setValue', myDate);
	}else{
		$('#endTime').datetimebox('setValue', data.endTime);
	}
}

function addRow(){
	window.location.href = "/product/list2.jsp";
}

function updateOrderStatusSel(data){
	var obj = document.getElementById('orderStatus');
	obj.options.length=0;
	
	obj.options.add(new Option("初始生成" , 1));
	obj.options.add(new Option("提交商家" , 2));
	obj.options.add(new Option("未付款" , 3));
	obj.options.add(new Option("已付款" , 4));
	obj.options.add(new Option("未发货" , 5));
	obj.options.add(new Option("已发货" , 6));
	obj.options.add(new Option("交易成功" , 7));
	obj.options.add(new Option("交易关闭" , 8));
	obj.options.add(new Option("待评价"   , 9));
	
	for(i = 0; i < obj.length; i++){
		if(obj[i].text == data.status){
			obj[i].selected = true;
		}
	}
}

function updateOrderInfo(data){
	$("#orderId").textbox("setValue", data.id);
	$("#payment").textbox("setValue", data.payment);
	$("#clientName").textbox("setValue", data.clientName);
	$("#clientChineseName").textbox("setValue", data.clientChineseName);
	$("#receiverMobile").textbox("setValue", data.receiverMobile);
	$("#receiverAreaName").textbox("setValue", data.receiverAreaName);

	updateOrderDateTimeInfo(data);
//
	updateOrderStatusSel(data);
	updatePaymentTypeSel(data);
	return;
}


function updatePaymentTypeSel(data){
	var obj = document.getElementById('paymentType');
	obj.options.length=0;
	
	obj.options.add(new Option("在线支付" , 1));
	obj.options.add(new Option("货到付款" , 2));
	
	for(i = 0; i < obj.length; i++){
		if(obj[i].text == data.paymentType){
			obj[i].selected = true;
		}
	}
}

function editRow(){
	var tableNum = $("#orderlist tr").length;
	
	//alert(tableNum);
	if($("#orderlist tr").length == 0){
		alert("此订单下没有添加商品，请先添加商品");
		return;
	}
	
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
	    	"id" :         $('#orderId').val(),
	    	"status" :     $("#orderStatus option:selected").text(),
	    	"payment" :    $("#payment").val(),
			"paymentType" : $("#paymentType option:selected").text(),
			"paymentTime" : $('#paymentTime').datetimebox('getValue'),
			"consignTime" : $('#consignTime').datetimebox('getValue'),
			"endTime" :     $('#endTime').datetimebox('getValue'),
			"clientChineseName" : $("#clientChineseName").val(),
			"receiverMobile" :   $("#receiverMobile").val(),
			"receiverAreaName" : $("#receiverAreaName").val(),
	    },
		url : '/order/modify.do',
		success : function(data) {
			 alert("更改订单基本信息成功！");
			 //window.reloation.ref = "order/Edit2.jsp";
			 window.location.href = "client/list2.jsp";
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	
}

function decGoodsNumber(goodsId){
	alert("goodsId = " + goodsId);
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
			"orderId": $('#orderId').val(),
			"goodsId": goodsId,
			"number": -1
		},
	    dataType : 'json',
		url : '/ordergoods/modifyGoodsNumber.do',
		success : function(data) {
			 //alert("ok");
			 if (data != null) {  
				 updateOrderList(data);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}


function addGoodsNumber(goodsId){
	alert("goodsId = " + goodsId);
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
			"orderId": $('#orderId').val(),
			"goodsId": goodsId,
			"number": 1
		},
	    dataType : 'json',
		url : '/ordergoods/modifyGoodsNumber.do',
		success : function(data) {
			 alert("ok");
			 if (data != null) {  
				 updateOrderList(data);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}

function checkOrderStatusField(obj){
	//alert("value =" + obj);
}

function checkPaymentTypeField(obj){
	//alert("value =" + obj);
}
</script>
  
<body  class="easyui-layout" style="width:100%;height:100%;">
     <!--- <div data-options="region:'north',split:false,border:true" style="overflow:hidden;height:90px;z-index:1">
		<iframe src="top.jsp" width="100%" name="topFrame" scrolling="No" id="topFrame" title="topFrame"></iframe>
	</div> ---> 
	<div data-options="region:'west',split:false,border:true" style="width:30%;">
	    
    	<div class="place">
			<span>位置：</span>
			<ul class="placeul">
			<li><a href="javascript:void(0);">首页</a></li>
			<li><a href="javascript:void(0);">订单管理</a></li>
			<li><a href="javascript:void(0);">添加商品</a></li>
			</ul>
		</div>
		<br />
		<div class="box-body" style="text-align:left; align-items:center; ">	
		   <label for="ordernum">订单号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" editable="false" id="orderId" name="orderId"  value = "${order.id}">
		   <br></br>
		   <label for="ordernum">订单状态&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		   <select id="orderStatus" onchange="checkOrderStatusField(this.value)">
			   <option value="1">初始生成</option>
			   <option value="2">提交商家</option>
			   <option value="3">未付款</option>
			   <option value="4">已付款</option>
			   <option value="5">未发货</option>
			   <option value="6">已发货</option>
			   <option value="7">交易成功</option>
			   <option value="8">交易关闭</option>
			   <option value="9">待评价</option>
		   </select>
		   <br></br>
		   <label for="ordernum">支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		   <select id="paymentType" onchange="checkPaymentTypeField(this.value)">
			   <option value="1">在线支付</option>
			   <option value="2">货到付款</option>
		   </select>
		   <br></br>
	
		   <label for="payment">金额&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" editable="false" id="payment" name="payment" value = "${order.payment}"><br></br>
		   <label for="paymentTime">付款时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-datetimebox" id="paymentTime" name="paymentTime"  value="" data-options="required:true" style="width:180px"><br></br>
		   <label for="consignTime">发货时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-datetimebox" id="consignTime" name="consignTime" value="" data-options="required:true" style="width:180px"><br></br>
		   <label for="endTime">完成时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-datetimebox" id="endTime" name="endTime" value="" data-options="required:true" style="width:180px"><br></br>
		   <label for="clientName">买家名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="clientName" editable="false" name="username" value = "${order.clientName}"><br></br>
		   <label for="clientChineseName">中文名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="clientChineseName" name="clientChineseName" value = "${order.clientChineseName}"><br></br>
		   <label for="receiverMobile">联系方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="receiverMobile" name="receiverMobile" value = "${order.receiverMobile}"><br></br>
		   <label for="receiverAreaName">买家地址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="receiverAreaName" name="receiverAreaName" value = "${order.receiverAreaName}"><br></br>
		   <div class="tools">
				<ul class="toolbar">
					<input name="" type="button" onclick="editRow();" class="scbtn" value="确认"/></li>
					<input name="" type="button" onclick="window.location.reload();" class="scbtn" value="取消"/></li>
				</ul>
			</div>
		</div>
	  </div>
  </div> 
  
	<div data-options="region:'east',split:false" title="east" style="width:70%;">
		<div class="rightinfo">
			<div class="tools">
				<ul class="seachform">
				<li><label>商品名称</label><input class="easyui-textbox" id="title" name="title" type="text" ></li>
				<li><label>&nbsp;</label><input name="" type="button" onclick="getOrderById();" class="scbtn" value="查询"/></li>
				</ul>
				<ul class="toolbar">
				</ul>
				<ul class="toolbar1">
				</ul>
			</div>
		</div>
		
		<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
			<div title="<span class='tt-inner'>订单商品列表<br></span>" style="padding:10px">
				<table class="table table-border table-bordered table-hover table-bg" id="orderlist-table">
					<thead>
						<tr class="text-c">
						    <th style="width: 1%">
			                    <input id="selall" onclick="allcheck()" type="checkbox"/>
			                </th>
							<th style="width: 10%">商品名称</th>
							<th style="width: 10%">商品单价</th>
							<th style="width: 10%">商品数量</th>
							<th style="width: 10%">商品总金额</th>
							<th style="width: 10%">商品图片</th>
							<th style="width: 10%">商品描述</th>
							<th style="width: 10%">操作</th>
						</tr>
					</thead>
					<tbody id= "orderlist" >
									
				   </tbody>
				</table>
				<span><div class="easyui-pagination" data-options="total:20" id="pp" style="width:80%;margin-left:40px;"></div></span>
			</div>
		</div>
		
		<div class="tools" style="padding:10px">
			<ul class="toolbar">
				<input name="" type="button" onclick="addRow();" class="scbtn" value="新增商品"/></li>
				<input name="" type="button" onclick="deleteRows();" class="scbtn" value="删除商品"/></li>
				<input name="" type="button" onclick="" class="scbtn" value="确认"/></li>
			</ul>
		</div>
	
	</div>
     	
</body>

</html>
