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
    
    <title>订单管理</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" href="https://openlayers.org/en/v4.5.0/css/ol.css" type="text/css">
    <!--script start-->
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
  		<input type="hidden" data-shape="${shape}" id="shape"/>
  		<input type="hidden" data-viewparams="${VIEWPARAMS}" id="viewParam"/>
		<div class="ui label">矢量数据</div>
		<div class="result_display_vector"></div>
  	</div>
	
	<script>
	    $(document).ready(function(){
	    	var shape = $("#shape").attr("data-shape");
	    	var viewParams_vector = $("#viewParam").attr("data-viewparams");
	    	var typeName;	
	        if(shape == "Circle") {
				typeName = "census_china:getCensusByRadius";
			} else if(shape == "Polygon") {
				typeName = "census_china:getCensusbyRectangle"
			} else {
				typeName = "census_china:getCensusbyRectangle";
			}
			var gmlFormat = new ol.format.GML3();
			$.ajax({  
		      url: 'http://47.93.237.6:8080/map/census_china/ows',  
		      type: 'get', 
		      data: {  
		     	  service: 'WFS',  
		          version: '1.0.0',  
		          request: 'GetFeature',  
		          typeNames: typeName,  
		          maxFeatures:50,  
		          outputFormat: 'gml3',
		          VIEWPARAMS:viewParams_vector
		      },  
		      success:function(result){  
		    	  var serializer = new XMLSerializer;
		    	  var serialized = serializer.serializeToString(result);
		    	  $(".display_vector .result_display_vector").text(serialized);
		      },  
		      error: function(){  
		        alert("执行失败");    
		      }  
  });  
	    })
	</script>
	
  </body>
</html>
