<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>top</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<link rel="stylesheet" type="text/css" href="common/css/top.css" />  
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
	<script type="text/javascript" src="common/js/jquery.js"></script>
  </head>

<script language="javascript">

$(document).ready(function (){
	
	var homepageId = "${sessionScope.loginUser.name}"; //用户个人主页
	 
	var productchildrenList =
		[
			{
			    name: "商品类别",
			    url: "producttype/list2.jsp",
			},
			{
			    name: "商品",
			    url: "product/list2.jsp",
			}
			
		];
	
	var clientchildrenList =
		[
			{
			    name: "商家",
			    url: "client/list2.jsp",
			},
			{
			    name: "商家订单",
			    url: "client/order2.jsp",
			}
			
		];
	
	var userchildrenList =
		[
			{
			    name: "角色管理",
			    url: "role/list2.do",
			},
			{
			    name: "权限管理",
			    url: "right/list2.do",
			}
			
		];
	
	var orderchildrenList =
		[
			{
			    name: "订单管理",
			    url: "order/list2.jsp",
			}
			
		];
	
	var logchildrenList =
		[
			{
			    name: "日志管理",
			    url: "log/list2.do",
			}
			
		];
	
	var functionList =
	[
	{
		name: "商品管理",
	    url: "",
	    childrenList: productchildrenList,
	},
	{
	    name: "商家管理",
	    url: "",
	    childrenList: clientchildrenList,
	},
	
	{
	    name: "订单管理",
	    url: "",
	    childrenList: orderchildrenList,
	},
	{
	    name: "用户管理",
	    url: "",
	    childrenList: userchildrenList,
	},
	{
	    name: "日志管理",
	    url: "",
	    childrenList: logchildrenList,
	}
	];
	
    if(('${sessionScope.clientorder.clientName}' != '') && ('${sessionScope.clientorder.id}' != '')
       	 && ('${sessionScope.clientorder.status}' != '')){
       	var info = new Object();
       	
       	info = '[' + '${sessionScope.clientorder.clientName}' + '][' 
       	   + '${sessionScope.clientorder.id}' +  '][' + '${sessionScope.clientorder.status}' + ']';

        document.getElementById("orderinfo").innerHTML= '<a href="<%=basePath%>order/Edit2.jsp?id='
        	+ '${sessionScope.clientorder.id}' + '" target="rightFrame">' + info + '</a>';
    }
       
    
	var menuLevel1HtmlBody = ''; //用户一级菜单
	var menuLevel2HtmlBody = ''; //用户二级菜单
    for (var i = 0; i < functionList.length; i++)
    {
    	
		var userFunction = functionList[i];
    	var selectFlag = false;
	
		var childrenFunctionList = userFunction.childrenList;
		var divMenuLevel2HtmlBody = '';
		for(var j=0; j<childrenFunctionList.length; j++)
		{
			var childrenFunction = childrenFunctionList[j];
			if(childrenFunction.funId == homepageId)
			{
				var selectFlag = true;
				divMenuLevel2HtmlBody +=  '<li  class="Select"><a href="'+childrenFunction.url+'" target="rightFrame"><b>'+ childrenFunction.name +'</b></a></li>';
			}
			else
			{
				divMenuLevel2HtmlBody +=  '<li><a href="'+childrenFunction.url+'" target="rightFrame"><b>'+ childrenFunction.name +'</b></a></li>';
			}
		 }
		
		 divMenuLevel2HtmlBody += '</ul></div>'; 
		 if(selectFlag)
		 {
			 divMenuLevel2HtmlBody = (' <div class="Menu"><ul>' + divMenuLevel2HtmlBody);
		 }
		 else
		 {
			 divMenuLevel2HtmlBody = (' <div class="Menu Hide"><ul>' + divMenuLevel2HtmlBody);
		 } 
		 menuLevel2HtmlBody += divMenuLevel2HtmlBody; 
		
		 if(selectFlag)
		 {
			 menuLevel1HtmlBody += '<li class="Select"><a href="'+userFunction.url+'" target="rightFrame"><b>';	
		 }
		 else
		 {
			 menuLevel1HtmlBody += '<li><a href="javascript:void(0);" target="rightFrame"><b>';
		 }
		 menuLevel1HtmlBody +=  userFunction.name;
		 menuLevel1HtmlBody += '</b></a></li>';
	} 
    //刷新表格数据
	$("#menuLevel1").html(menuLevel1HtmlBody);
    $("#menuLevel2").html(menuLevel2HtmlBody);
	
    console.log("menuLevel1HtmlBody = " + menuLevel1HtmlBody);
    console.log("menuLevel2HtmlBody = " + menuLevel2HtmlBody);
	$('#Top .Toolbar1 .CentreBox .Menu .List1 li').mouseenter(function () {
        var index = $(this).parent().children().index(this);
        $(this).parent().children().each(function () {
            if ($(this).hasClass('Select')) {
                $(this).removeClass('Select');
            }
        });
        $(this).addClass('Select');

        $('#Top .Toolbar2 .CentreBox .Menu').each(function () {
            if (!$(this).hasClass('Hide')) {
                $(this).addClass('Hide');
            }
        });
        $('#Top .Toolbar2 .CentreBox .Menu').eq(index).removeClass('Hide');
    });

    $('#Top .Toolbar2 .CentreBox .Menu ul li a').mouseenter(function () {
        var index = $('#Top .Toolbar2 .CentreBox .Menu ul li a').index(this);
        $('#Top .Toolbar2 .CentreBox .Menu ul li').each(function () {
            if ($(this).hasClass('Select')) {
                $(this).removeClass('Select');
            }
        });
        $(this).parent().addClass('Select');
    });
    //console.log('${sessionScope.loginUser.name}');
    


    document.getElementById("username").innerHTML= '你好：【' + '${sessionScope.loginUser.name}'  + '】' ;
});

</script> 
  
<body >
	<div id="Top">
  		<div class="Toolbar1">
  			<div class="Orderinfo" id="orderinfo" style ='color:red;float:left;vertical-align:middle;display:inline-block;'>
			</div>
    		<div class="CentreBox">
      			<div class="Logo"><a href="javascript:void(0);" target="_self"><img src="common/css/images/top/Logo.png" alt="网站名称"/></a></div>
      			<div class="Menu"><ul class="List1" id="menuLevel1"></ul></div>
	  			<div class="UserInfo" style ="display:inline;">
					<div class="NickName" id="username" style ="display:inline;float:right;">
						<a href="javascript:void(0);" target="_self"></a>
					</div>
				</div>	
  			</div>
   		   
  		</div>
  		<div class="Toolbar2">
    		<div class="CentreBox" id="menuLevel2"></div>
  		</div>
	</div>
</body>
</html>
