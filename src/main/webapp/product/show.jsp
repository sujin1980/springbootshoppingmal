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
	    <title>查看商品</title>
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
    <script src="../static/jquery-3.3.1.min.js" type="text/javascript"></script>

<script type="text/javascript">

$(document).ready(function () {
	/*$("#imgfileupsel").change(function() {
        var $file = $(this);
        var fileObj = $file[0];
        var windowURL = window.URL || window.webkitURL;
        var dataURL;
        var $img = $("#productimg");
        
        if(fileObj && fileObj.files && fileObj.files[0]){
	        dataURL = windowURL.createObjectURL(fileObj.files[0]);
	        $img.attr('src',dataURL);
        }else{
	        dataURL = $file.val();
	        var imgObj = document.getElementById("productimg");
	        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
	        //imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
	        imgObj.src = dataURL;
        }
    });*/

	initField(${product.productType.productCategory.id});
	
});

var getTypeList = function (val)
{	
	$.ajax({
		type: "POST",
		data: {
			"id" : JSON.stringify(val)
		},
		url : 'producttype/getTypeListByCategoryStrId.do',	
		success : function(data) {			
			if (data != null) {
				var obj=document.getElementById('producttypesel');
				obj.options.length=0;
			    for (var i = 0; i < data.length; i++) {
			    	obj.options.add(new Option(data[i].name, data[i].id));
				} 
			    var obj2 = document.getElementById('productcategorysel' );
				for(i=0;i<obj2.length;i++){
				  if(obj2[i].value == ${product.productType.productCategory.id})
					  obj2[i].selected = true;
				}
			    
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
		}
	});
	 
}

var initField = function (val)
{	
	getTypeList(val);
}

var checkField = function (val)
{	
	var strid = null; 
	if(val.indexOf("=") > 0){
		strid = val.substring(0, val.indexOf("="));
	}else{
		strid = val;
	}
	
	getTypeList(parseInt(strid));	
}

/*
function uploadimage(fileData) {
    var formData = new FormData();
    formData.append('file', $('#imgfileupsel')[0].files[0]);
    
    $.ajax({
		type: "POST",
		data: formData,
		processData: false,
        contentType: false,
		url: "file/upload.do",
		success : function(data) {
		    var $img = $("#productimg");
		    $img.attr('src',data); 
			alert(data);		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
		}
	});
}

function canceluploadimage(fileData) {
	document.getElementById("imgfileupsel").value = "";
	$("#icon").val = "";
    $("#productimg").val = "";
    $("#productimg").src = "";
    
    var obj = $("#productimg");
    $("productimg").removeAttr("src");
    window.URL.revokeObjectURL(obj.src); 
    return;
}
*/



</script>
  
<body  class="easyui-layout" style="width:100%;height:100%;">
     <!--- <div data-options="region:'north',split:false,border:true" style="overflow:hidden;height:90px;z-index:1">
		<iframe src="top.jsp" width="100%" name="topFrame" scrolling="No" id="topFrame" title="topFrame"></iframe>
	</div> --->
	
	<div data-options="region:'east',split:false" title="" style="width:180px;"></div>
	<div data-options="region:'west',split:false" title="" style="width:100px;"></div>
	<div data-options="region:'south',split:false" title="" style="height:100px;"></div>
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:590px;z-index:1">
	    
			 <div class="place">
			 <span>位置：</span>
				<ul class="placeul">
				<li><a href="javascript:void(0);">首页</a></li>
				<li><a href="javascript:void(0);">商品管理</a></li>
				<li><a href="javascript:void(0);">查看商品</a></li>
				</ul>
			</div>
			<br />
		<div class="box-body" style="text-align:center; align-items:center; ">	
			<table cellpadding="0" cellspacing="1" border="0">
			    <tr>    
			        
			        <td><input id="userInputCondition" name="userInputCondition" type="text" style="width:200px;"></input></td>                            
			    </tr>                        
		    </table>
		   <input type="text" id="productid" name="productid" hidden="true" editable="false" value = "${product.id}">
		   <label id="id" for="名称"  >名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="name" value = "${product.name}" name="name"><br></br>
		   <label for="一级分类">一级分类&nbsp;</label>
		   <select id="productcategorysel" name="dept" style="width:150px;" onchange="checkField(this.value)">
			   <option value="2">有偿用品</option>
			   <option value="3">皮草</option>
			   <option value="4">易耗品</option>
		   </select>
		   <br></br>
		   <label for="二级分类">二级分类&nbsp;</label>
		   <select id="producttypesel" style="width:150px;">
		   </select>
		   <br></br>
		   <label for="价格">价格&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="price" name="price" value = "${product.price}" style="width:150px;"><br></br>
		   <div>
		      <label for="图片">图片</label><br></br>
		      <tr>	
			       <td>
			      		<img alt="" id="productimg" src="${product.icon}" width="100px" height="100px">	            	 
			       </td>
			       <br />
			       
			   </tr>
		   <div>	 
		   <br></br>
		   <label for="商品介绍">商品介绍&nbsp;</label><input class="easyui-textbox" id="remarks" name="remarks" value = "${product.remarks}" style="width:150px;"><br></br>
		   
	  </div>
  </div>  	
</body>
</html>
