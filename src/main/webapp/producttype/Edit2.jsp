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
	
	$("#imgfileupsel").change(function() {
        var $file = $(this);
        var fileObj = $file[0];
        var windowURL = window.URL || window.webkitURL;
        var dataURL;
        var $img = $("#typeimage");
        
        if(fileObj && fileObj.files && fileObj.files[0]){
	        dataURL = windowURL.createObjectURL(fileObj.files[0]);
	        $img.attr('src',dataURL);
        }else{
	        dataURL = $file.val();
	        var imgObj = document.getElementById("typeimage");
	        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
	        //imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
	        imgObj.src = dataURL;
        }
    });
	
});


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
		    var $img = $("#typeimage");
		    $img.attr('src',data); 
			//console.log(data);		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("checkField fail");
		}
	});
}

function canceluploadimage(fileData) {
	document.getElementById("imgfileupsel").value = "";
	$("#icon").val = "";
    $("#typeimage").val = "";
    $("#typeimage").src = "";
    
    var obj = $("#typeimage");
    $("typeimage").removeAttr("src");
    window.URL.revokeObjectURL(obj.src); 
    return;
}

function isDecimal(item) {
    var obj = $(item);
    if (obj.length > 0) {
        if ($(obj).val() != null && typeof ($(obj).val()) != "undefined") {
            var str = $(obj).val().toString();
            if (str != "") {
                var pattern = '^-?[1-9]\\d*$|^-?0\\.\\d*$|^-?[1-9]\\d*\\.\\d*$';
                var reg = new RegExp(pattern, 'g');
                if (reg.test(str)) {
                    return true;
                } else {
                    if (str.match(/[^0-9\.-]/g) != null) {
                        if (str.match(/[^0-9\.-]/g).length > 0) {
                            str = str.replace(/[^0-9\.-]/g, '');
                            $(item).val(str);
                        }
                    }
                }
            }
        }
    }
    return false;
}

function editRow()
{
	if($("#typeimage").attr('src').indexOf("upload") < 0){
		//console.log($("#typeimage").attr('src'));
		console.log("请先上传商品类型图片！");
		return;
	}

	if($("#name").val().trim().length == 0){
		console.log("请输入商品类型名称！");
		return;
	}

	$.ajax({
		type: "POST",
		data: {
			"id":   ${producttype.id},
			"name":   $("#name").val(),
			"categoryid":  ${categoryid},
			"picture":   $("#typeimage").attr('src'),
			"remarks": $("#remarks").val()
		},
		url : '/producttype/edit2.do',
		success : function(data) {			
			//console.log("editRow success");
			window.location.href = "producttype/list2.jsp";
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("editRow fail");
			//window.location.replace("https://www.runoob.com");
		}
	});
}
</script>
  
<body  class="easyui-layout" style="width:100%;height:100%;">	
	<div data-options="region:'east',split:false" title="" style="width:180px;"></div>
	<div data-options="region:'west',split:false" title="" style="width:100px;"></div>
	<div data-options="region:'south',split:false" title="" style="height:100px;"></div>
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:590px;z-index:1">
	    
			 <div class="place">
				<span>位置：</span>
				<ul class="placeul">
				<li><a href="javascript:void(0);">首页</a></li>
				<li><a href="javascript:void(0);">商品管理</a></li>
				<li><a href="javascript:void(0);">修改商品类型</a></li>
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
				       <br />
				       
				       <td>
				       		<a href="javascript:;" class="a-upload">
				       			<input type="file"  id="imgfileupsel" title="选择图片"  accept="image/gif,image/png"  size="1" >选择图片
				       		</a> 
				       </td>
				       <br />
					    <td> 
					   		<button type="button" class="btn btn-default" title="上传" onclick="uploadimage()"><i class="fa fa-trash-o"></i>上传</button>
			       		</td> 
				   </tr>
			   <div>	 
			   <br></br>
			   <label for="商品类型介绍">商品类型介绍&nbsp;</label><input class="easyui-textbox" id="remarks" value = "${producttype.remarks}" name="remarks"  style="width:150px;"><br></br>
			   
		   </form>
		    <div style="text-align:center;padding:5px">
		    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editRow()">确认</a>
		    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()">取消</a>
		    </div>	   
	  </div>
  </div>  	
</body>

</html>
