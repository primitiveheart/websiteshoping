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
    
    <title>我的订单</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <!--script start-->
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script type="text/javascript" src="resources/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="resources/js/semantic.min.js"></script>
    <!--script end-->

    <!--style start-->
    <link rel="stylesheet" href="resources/css/semantic.min.css" type="text/css"/>
     <style type="text/css">
     		body > .ui.container{
     			margin-top:3em;
     		}
     </style>
    <!--style end--> 
  </head>
  
  <body>
	  	
	<!--把菜单包含进来  -->
	<%@include file="../commons/menu.jsp"%>
  		
  	<div class="ui container">
  		<table class="ui celled table">
  			<thead>
				<tr>
					<th>商品</th>
					<th>单价</th>
					<th>数量</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${orderProudcts != null}">
					<c:forEach items="${orderProudcts}" var="op" varStatus="status">
						<tr>
							<td colspan=5>
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
											<div class="ui primary button">删除</div>
										</td>
									</tr>
								</c:forEach>
							</c:if>
					</c:forEach>
				</c:if>
			</tbody>
  		</table>
  	</div>
</body>
</html>