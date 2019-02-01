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
	 <link rel="stylesheet" type="text/css" href="common/css/style.css" />
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css" />
	
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
<script>
function addRow(){
	//window.open("/client/toAdd2");
	window.location.href = "/client/toAdd2";
}

function deleteRows(){
    var che = document.getElementsByName("clientcheckbox");  
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
		url : '/client/deleteClients.do',
		success : function(data) {
			 alert("ok");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
}

function allcheck() {
	var allche = document.getElementById("selall");  
    var che = document.getElementsByName("clientcheckbox");  
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
   
 function clientsclickcheck(obj) {
	if(obj.checked==false){  
        var allche = document.getElementById("selall");  
        allche.checked = false;
    }
}
     
function  editRow(obj){
    var i = 1;
	alert(i);
	return;	 
}


function getClientByName(){			
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
			"name" : $("#name").val()
		},
	    dataType : 'json',
		url : '/client/findClientByName.do',
		success : function(data) {
			 alert("ok");
			 if (data != null) {  
				 //var obj=document.getElementById('productlist');
				 $("clientlist").html("");
				 var tbodyhtmlod = '';
			
				 for(var i= 0; i< data.length; i++){
					 tbodyhtmlod += '<tr class="odd gradeX">';
					  tbodyhtmlod += '<td> <input id=' + data[i].id + 'class="odd gradeX" type="checkbox" name="goodscheckbox" '
					      + 'style="visibility: visible" onclick="goodsclickcheck(this)"> </td>';
					  tbodyhtmlod += '<td class="tdcenter" > ' + data[i].name + '</td>';
					  tbodyhtmlod += '<td class="tdcenter"> ' + data[i].chineseName + '</td>';
					  tbodyhtmlod += '<td class="tdcenter"> ' + data[i].telephone + '</td>';
					  tbodyhtmlod += '<td class="tdcenter"> ' + data[i].address + '</td>';
					  tbodyhtmlod += '<td class="tdcenter"> ' + data[i].weixin   + '</td>';
					  tbodyhtmlod += '<td class="tdcenter"> ' + data[i].qq   + '</td>';
					  tbodyhtmlod += '<td class="tdcenter"> ' + data[i].remarks + '</td>';
					  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
					      '<a href="<%=basePath%>/product/toEdit2?id=' + data[i].id + '">查看订单</a> ';
					  tbodyhtmlod += ' <a href="<%=basePath%>/client/toOrder2?id'
						  + data[i].id + ' onclick="client_confirm(' + data[i].id + ')">创建订单</a> </td> </tr>';
				 }

				 console.log(tbodyhtmlod);
				 $("#clientlist").html(tbodyhtmlod);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
	
	return;
}

function client_confirm(obj) 
{
	var mymessage = new Object;
	var str = '';
	str = '确认为商家"' + '${client.name}' + '"生成订单吗？'; 
	
	mymessage = confirm(str);
	if(mymessage != true){
		return;
	}
	
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
	    	"id" : obj
	    },
		url : '/order/create2.do',
		success : function(data) {
			 if(data != "OK"){
				 alert("create order failed!");
			 }else{
				 alert()
				 window.location.href = "client/toOrder2?id=" + obj;
			 }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("fail");
		}
	});	 
}

</script>
 
<body class="easyui-layout">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
		<li><a href="javascript:void(0);">首页</a></li>
		<li><a href="javascript:void(0);">商家管理</a></li>
		<li><a href="javascript:void(0);">商家</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<div class="tools">
		<ul class="seachform">
		<li><label>商家名称</label><input id="name" name="name" type="text" class="scinput" /></li>
		
		<li><label>&nbsp;</label><input name="" type="button" onclick="getClientByName();" class="scbtn" value="查询"/></li>
		</ul>
		<ul class="toolbar">
		</ul>
		<ul class="toolbar1">
		</ul>
		</div>
	</div>
	
	<div class="tools">
		<ul class="toolbar">
			<button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
	        <button type="button" class="btn btn-default" title="删除"  onclick="client_confirm()"><i class="fa fa-trash-o"></i> 删除</button>
	        <button type="button" class="btn btn-default" title="刷新" onclick="window.location.reload();"><i class="fa fa-refresh"></i> 刷新</button>
		</ul>
	</div>
	
	<div class="container">
	<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
	<div title="<span class='tt-inner'>商家列表<br></span>" style="padding:10px">
		<table class="table table-border table-bordered table-hover table-bg">
			<thead>
				<tr class="text-c">
					 <th style="width: 1%">
		                 <input id="selall" onclick="allcheck()" type="checkbox"/>
		             </th>
					<th style="width: 10%">名称</th>
					<th style="width: 10%">中文名称</th>
					<th style="width: 10%">电话</th>
					<th style="width: 15%">地址</th>
					<th style="width: 10%">微信联系方式</th>
					<th style="width: 10%">QQ</th>
					<th style="width: 25%">描述</th>
					<th style="width: 10%">操作</th>
				</tr>
			</thead>
			<tbody id="clientlist">
				<c:forEach items="${ clients }" var="client">
					<tr class="odd gradeX">
					    <td><input id=${client.id} class="odd gradeX" type="checkbox" name="clientcheckbox" style="visibility: visible" onclick="clientsclickcheck(this)"> </td>
						<td> ${client.name} </td>
						<td> ${client.chineseName} </td>
						<td> ${client.telephone} </td>
						<td> ${client.address} </td>
						<td> ${client.weixin} </td>
						<td> ${client.qq} </td>
						<td> ${client.remarks} </td>
						<td class="text-center">                                          
						  <a href="<%=basePath%>/client/toOrder2?id=${client.id}">查看订单</a>
		             	  <a href="javascript:void(0);" onclick="client_confirm(${client.id})">创建订单</a>
		              </td>
					</tr>
				</c:forEach>				
		   </tbody>
		</table>
		<span><div class="easyui-pagination" data-options="total:20" id="pp" style="width:80%;margin-left:40px;"></div></span>
	</div>
	</div>
	</div>
	
</body>

</html>