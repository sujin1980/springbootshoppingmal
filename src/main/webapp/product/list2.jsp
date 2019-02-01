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
			 alert("ok");
			 if (data != null) {
				var obj=document.getElementById('producttypesel');
				obj.options.length=0;
			    for (var i = 0; i < data.length; i++) {
			    	obj.options.add(new Option(data[i].name, data[i].id));
				} 
			    var obj2 = document.getElementById('productcategorysel' );
				for(i=0;i<obj2.length;i++){
				  if(obj2[i].value == 2)
					  obj2[i].selected = true;
				}
			    
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
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
     
function  editRow(obj){
    var i = 1;
	alert(i);
	return;	 
}

function getDataRow(h){ 
	   var row = document.getElementById('productlist'); //创建行 
	   var idCell = document.createElement('td'); //创建第一列id 
	   idCell.innerHTML = h.id; //填充数据 
	   row.appendChild(idCell); //加入行 ，下面类似 
	   var nameCell = document.createElement('td');//创建第二列name 
	   nameCell.innerHTML = h.name; 
	   row.appendChild(nameCell); 
	   var jobCell = document.createElement('td');//创建第三列job 
	   jobCell.innerHTML = h.job; 
	   row.appendChild(jobCell); 
	   //到这里，json中的数据已经添加到表格中，下面为每行末尾添加删除按钮 
	   var delCell = document.createElement('td');//创建第四列，操作列 
	   row.appendChild(delCell); 
	   var btnDel = document.createElement('input'); //创建一个input控件 
	   btnDel.setAttribute('type','button'); //type="button" 
	   btnDel.setAttribute('value','删除');  
	   //删除操作 
	   btnDel.onclick=
	   delCell.appendChild(btnDel); //把删除按钮加入td，别忘了 
	   return row; //返回tr数据   
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
			 alert("ok");
			 if (data != null) {  
				 //var obj=document.getElementById('productlist');
				 $("productlist").html("");
				 var tbodyhtmlod = '';
			
				 for(var i= 0; i< data.length; i++){
					  
					  
					  tbodyhtmlod += '<tr class="odd gradeX">';
					  tbodyhtmlod += '<td> <input id=' + data[i].id + 'class="odd gradeX" type="checkbox" name="goodscheckbox" '
					      + 'style="visibility: visible" onclick="goodsclickcheck(this)"> </td>';
					  tbodyhtmlod += '<td> ' + data[i].id   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].name + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].productType.name + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].productType.productCategory.name + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].price   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].remarks + '</td>';
					  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
					      '<a href="<%=basePath%>/product/toEdit2?id=' + data[i].id + '">查看</a> ';
					  tbodyhtmlod += '<a href="javascript:void(0);"  onclick="addProducToOrder(' + data[i].id + ')">加入订单</a></td> </tr>';
				 }

				 console.log(tbodyhtmlod);
				 $("#productlist").html(tbodyhtmlod);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	return;
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
			 alert("ok");
			 
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
	
	<div class="container">
	<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
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
				<c:forEach items="${ products }" var="product">
					<tr  class="odd gradeX">
					    <td><input id=${product.id} class="odd gradeX" type="checkbox" name="goodscheckbox" style="visibility: visible" onclick="goodsclickcheck(this)"> </td>
						<td> ${product.id} </td>
						<td> ${product.name} </td>
						<td> ${product.productType.name} </td>
						<td> ${product.productType.productCategory.name} </td>
						<td> ${product.price} </td>
						<td> ${product.remarks} </td>
						<td class="text-center">                                          
		             	   <a href="<%=basePath%>product/toEdit2?id=${product.id}">查看</a>  
		             	   <a href="javascript:void(0);" onclick="addProducToOrder(${product.id})">加入订单</a>
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