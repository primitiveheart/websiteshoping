<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>管理员主界面</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <!--script start-->
    <script type="text/javascript" src="resources/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="resources/js/semantic.min.js"></script>
    <!--script end-->
    
    <!--style start-->
    <link rel="stylesheet" href="resources/css/semantic.min.css" type="text/css"/>
    <style type="text/css">
    	body{
    		background-color: #FFFFFF;
    	}
    	.ui.menu .item img.logo{
    		margin-right:1.5em;
    	}
    	.main.container{
    		margin-top:5em;
    	}
    </style>
    <!--style end--> 
  </head>
  <body>
  	<div class="ui fixed inverted menu">
  		<div class="ui container">
  			<a href="#" class="header item">
  				<img class="logo" src="resources/images/logo.jpg"/>
  				后台管理系统
  			</a>
  			<c:if test="${admin != null && admin.username != null}">
  				<a href="#" class="item">欢迎您：${admin.username}</a>
  				<a href="admin/logout.html" class="item">注销</a>
  			</c:if>
  		</div>
  	</div>
  	
	<div class="ui main text container">
		<table class="ui celled table">
			<thead>
				<tr>
					<th>商品</th>
					<th>单价</th>
					<th>数量</th>
					<th>状态</th>
					<th>用户名</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${page!=null && page.list != null}">
					<c:forEach items="${page.list}" var="op" varStatus="status">
						<tr>
							<td colspan=6>
								<h3 class="ui header">日期:${op.date}&nbsp;&nbsp;订单号:${op.uuid}</h3>
							</td>
						</tr>
						<c:if test="${op.products != null}">
								<c:forEach items="${op.products}" var="product">
									<tr>
										<td>
											<div class="ui item">
												<div class="content">
													<a class="header">产品的详细说明</a>
													<div class="description">
														<p>
															年份：${product.year}<br>
															面积：${product.area}<br>
															数据选项：${product.index}<br>
															产品类型：${product.inputForm}
														</p>
													</div>
												</div>
											</div>
											
										</td>
										<td>
											<p class="ui center aligned">${op.price}</p>
										</td>
										<td>
											<p class="ui center aligned">1</p>
										</td>
										<td>
											<p class="ui center aligned">${product.state}</p>
										</td>
										<td>
											<p class="ui center aligned">${op.username}</p>
										</td>
										<td>
											<div class="ui primary check button" data-uuid="${op.uuid}" data-id="${product.id}"
											 data-user="${op.username}" data-state="${product.state }">审核</div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
					</c:forEach>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="6">
						<div class="ui right floated pagination menu">
							<div class="item" >共${page.totalPage}页</div>
							<div class="item">当前第${page.pageNum}页</div>
							<a class="icon item" href="admin/manage.html?pageNum=${page.pageNum - 1}&pageSize=2">
								<i class="left chevron icon"></i>
							</a>
							<c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
								<a class="item" href="admin/manage.html?pageNum=${pageNum}&pageSize=2">${pageNum}</a>
							</c:forEach>
							<a class="icon item" href="admin/manage.html?pageNum=${page.pageNum + 1}&pageSize=2">
								<i class="right chevron icon"></i>
							</a>
							<div class="item"><button class="ui primary button" id="go">跳转</button></div>
							<div class="item">
								<input type="text" id="goto" placeholder="页面"/>
							</div>
						</div>
					</th>
				</tr>
			</tfoot>
		</table> 
	</div>
  </body>
  	<script type="text/javascript">
  		$(document).ready(function(){
  		
  			$(".ui.check.button").on("click",function(){
  				var uuid = $(this).attr("data-uuid");
  				var id = $(this).attr("data-id");
  				var username = $(this).attr("data-user");
  				var state = $(this).attr("data-state");
  				$.ajax({
  					url:"admin/acquireSecretKey.html",
  					type:"POST",
  					data:{
  						order_uuid:uuid,
  						product_id:id,
  						username:username,
  						state:state
  					},
  					success:function(result){
  						//重新刷新页面
  						$(location).attr("href","admin/manage.html");
  					}
  				})
  			})
  			
  			$("#go").on("click", function(){
  				var maxPage = ${page.totalPage};
  				var pages = $("#goto").val();
	  			if(pages == null || pages == "" ){	
	  				alert("页面不能为空");
	  				return;
	  			}
	  			if(!pages.match("\\d+")){
	  				alert("页面只能是数字");
	  				return;
	  			}
	  			if(pages<1 || pages> maxPage){
	  				alert("没有当前页码");
	  				return;
	  			}
	  			
	  			$(window).attr("location","admin/manage.html?pageNum="+pages + "&pageSize=2");
  			})
  		})
  		
  	</script>
</html>
