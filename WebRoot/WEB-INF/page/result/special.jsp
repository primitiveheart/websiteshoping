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
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
    <script src="https://openlayers.org/en/v4.5.0/build/ol.js"></script>
    <script type="text/javascript" src="resources/js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="resources/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="resources/js/semantic.min.js"></script>

    <script type="text/javascript" src="resources/js/layer.js"></script>
    <script type="text/javascript" src="resources/js/addInteraction.js"></script>
    <script type="text/javascript" src="resources/js/calcArea.js"></script>
    <script type="text/javascript" src="resources/js/result-special.js"></script>
    <script type="text/javascript" src="resources/js/display-front-result.js"></script>
    <script type="text/javascript" src="resources/js/result-vector.js"></script>
    <!--script end-->

    <!--style start-->
    <link rel="stylesheet" href="resources/css/semantic.min.css" type="text/css"/>
    <!--
     <link rel="stylesheet" href="resources/css/base.css" type="text/css"/>
       -->
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
		<div class="ui large longer modal">
			<div class="header">
				专题图
			</div>
			<div class="scrolling image content">
				<div class="description" id="description"></div>
			</div>
			<div class="actions">
				<div class="ui positive right labeled icon button">返回</div>
			</div>
		</div>
		
  	</div>
	
	<script>
	
	    $(document).ready(function(){	
	    	var shape = $("#shape").attr("data-shape");
	    	var viewParams_vector = $("#viewParam").attr("data-viewparams");	
			var layers = "";
			var extent = [71.0, 16.0, 136.0, 55.0];
	
			if(shape == "Circle") {
				layers = "census_china:getCensusByRadius";
			} else if(shape == "Polygon") {
				layers = "census_china:getCensusbyRectangle"
			} else {
				layers = "census_china:getCensusbyRectangle";
			}
		
			
			var middle_layer = new ol.layer.Tile({
				extent: extent,
				source: new ol.source.TileWMS({
					url: "http://47.93.237.6:8080/map/census_china/wms",
					params: {
						'LAYERS': layers,
						'VERSION': '1.1.0',
						'TRANSPARENCY': true,
						'VIEWPARAMS': viewParams_vector,
						'TILED': true
					},
					serverType: 'geoserver'
				})
			})
			
			//投影
			var projection = ol.proj.get("EPSG:4326");
			
			var map = new ol.Map({
				layers: [middle_layer],
				target: description,
				view: new ol.View({
					center: ol.extent.getCenter(extent),
					projection: projection,
					zoom: 4
				}),
			})
			
	        	
			//专题图
       		$(".ui.modal").modal({
       			offset:600,
       			onApprove:function(){
       				return true;
       			}
       		}).modal('show');
	    })
	
	</script>
	
  </body>
</html>
