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
  		 <div class="main">
	    	<div id="order">
		        <h1>选择类型</h1>
		        <!--
		        <label for="year">年份</label>
		        <input type="text" class="Wdate" name="year" id="year" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy',readonly:true,skin:'whyGreen'})">
		        <label for="year"></label>
		          -->
		          
		       	<div class="ui big header">选择年份</div>
		       	<select multiple="" name="year" id="year" class="ui year search fluid normal dropdown">
		       		<option value="">年份</option>
		       		<option value="1980">1980</option>
		       		<option value="1981">1981</option>
		       		<option value="1982">1982</option>
		       		<option value="1983">1983</option>
		       		<option value="1984">1984</option>
		       		<option value="1985">1985</option>
		       		<option value="1986">1986</option>
		       		<option value="1987">1987</option>
		       		<option value="1988">1988</option>
		       		<option value="1989">1989</option>
		       		
		       		<option value="1990">1990</option>
		       		<option value="1991">1991</option>
		       		<option value="1992">1992</option>
		       		<option value="1993">1993</option>
		       		<option value="1994">1994</option>
		       		<option value="1995">1995</option>
		       		<option value="1996">1996</option>
		       		<option value="1997">1997</option>
		       		<option value="1998">1998</option>
		       		<option value="1999">1999</option>
		       		
		       		<option value="2000">2000</option>
		       		<option value="2001">2001</option>
		       		<option value="2002">2002</option>
		       		<option value="2003">2003</option>
		       		<option value="2004">2004</option>
		       		<option value="2005">2005</option>
		       		<option value="2006">2006</option>
		       		<option value="2007">2007</option>
		       		<option value="2008">2008</option>
		       		<option value="2009">2009</option>
		       		
		       		<option value="2010">2010</option>
		       		<option value="2011">2011</option>
		       		<option value="2012">2012</option>
		       		<option value="2013">2013</option>
		       		<option value="2014">2014</option>
		       		<option value="2015">2015</option>
		       		<option value="2016">2016</option>
		       		<option value="2017">2017</option>
		       	</select>
		        <!--  
		        <form class="form-inline">
		            <label>选择区域的类型：</label>
		            <select id="type">
		                <option value="LineString" selected="selected">矩形</option>
		                <option value="Circle">圆形</option>
		                <option value="Polygon">多边形</option>
		            </select>
		        </form>
		        -->
		        <div class="ui big header">选择区域的类型</div>
		        <div class="ui shapeSelection selection dropdown ">
		        	<input type="hidden" name="shapeSelection"/>
		        	<i class="dropdown icon"></i>
			        <div class="default text">选择区域的类型</div>
		        	<div class="menu">
		        		<div class="item" data-value="LineString">矩形</div>
		        		<div class="item" data-value="Circle">圆形</div>
		        		<div class="item" data-value="Polygon">多边形</div>
		        	</div>
		        </div>
		        
		        <div id="map"></div>
		        
		        <div class="ui big header">产品类型</div>
		        <div class="ui productType selection dropdown">
		        	<input type="hidden" name="productType"/>
		        	<i class="dropdown icon"></i>
		        	<div class="default text">产品类型</div>
		        	<div class="menu">
		        		<div class="item" data-value="data">矢量数据</div>
		        		<div class="item" data-value="special">专题图</div>
		        		<div class="item" data-value="sum">汇总值</div>
		        	</div>
		        </div>
		        <!--  
		        <h1>产品类型</h1>
		        <input type="checkbox" name="result" id="data" value="data">矢量数据
		        <input type="checkbox" name="result" id="special" value="special">专题图
		        <input type="checkbox" name="result" id="sum" value="sum">汇总值<br><br><br>
		        -->
		        
		       <div class="dataSelectionAddTitle">
		       		<div class="ui big header">数据选项</div>
			        <select multiple="" class="ui search fluid dataSelection normal dropdown">
			        	<c:if test="${requestScope.index != null}">
				        	<c:forEach items="${requestScope.index}" var = "s" varStatus="vs">
				        		<option type="checkbox" name="index" value="${s}">${s}</option>
					        </c:forEach>
		      		    </c:if>
			        </select>
		       </div>
		        <!--  
		        <h2>数据选项</h2>
		        <c:if test="${requestScope.index != null}">
		        	<c:forEach items="${requestScope.index}" var = "s" varStatus="vs">
		        		<input type="checkbox" name="index" value="${s}"/>${s} &nbsp;&nbsp;&nbsp;&nbsp;
			        	<c:if test="${vs.index!=0 && vs.index%4==0}">
			        		<br/>
			        	</c:if>
			        </c:forEach>
		        </c:if>
		        -->
		        
		       
		        <button id="next" class="ui right labeled icon blue button">
		        	下一步
		        	<i class="right arrow icon"></i>
	        	</button>
		    </div>
		</div>

		<div id="display">
		    <label>年份:</label><label  for="year" id="dis_year" name="dis_yaer"></label><br>
		    <label>选取区域的工具：</label><label id="shape_type"></label><br>
		    <label>选择区域的面积(单位:km):</label><label id="area" name="area"></label>
		    <lable><h2>统计</h2></label>
		    <label class="sum"></label><br/><br/>
		    
		    <button id="previous" class="ui left labeled icon blue button">
		        	上一步
		       <i class="left arrow icon"></i>
		    </button>
		    
		    <button id="createOrder" class="ui primary blue button">
		    	创建订单
		    </button>
	    	
	    	<div class="ui black big label">输出结果</div><br><br>
	    	<div class="ui green button resultVector">矢量数据</div>
	    	<div class="ui green button resultSpecial">专题图</div>
	    	<div class="ui green button resultSum">汇总值</div>
		</div>
		
		<div class="ui large longer modal">
			<div class="header">
				专题图
			</div>
			<div class="scrolling image content">
				<div class="description"></div>
			</div>
			<div class="actions">
				<div class="ui positive right labeled icon button">返回</div>
			</div>
		</div>
		
		<div class="display_vector">
			<div class='ui left labeled icon blue button back_vector'>
				返回
				<i class="left arrow icon"></i>
			</div><br/>
			<div class="ui label">矢量数据</div>
			<!--
				<div class="ui selection dropdown">
					<input type="hidden" name="selection">
					<div class="default text">Select</div>
					<div class="menu"></div>
				</div>
				<div class="container" style="height:90%;width:30%;overflow:scroll">
				</div>
			-->
			<div class="result_display_vector" style="height:90%;width:30%;overflow:scroll"></div>
		</div>
  	</div>
	
	<script>
		
	    var map = new ol.Map({
	        layers: layers,
	        target: 'map',
	        view: new ol.View({
	            center: [12959773,4853101],
	            zoom: 12
	        })
	    });
	
	    var source = new ol.source.Vector();
	    var vector = new ol.layer.Vector({
	        source:source
	    });
	
	    map.addLayer(vector);
	
	    var draw_style = new ol.style.Style({
	        fill:new ol.style.Fill({
	            color:'rgba(255, 255, 255, 0.2)'
	        }),
	        stroke:new ol.style.Stroke({
	            color:"#ffcc33",
	            width:2
	        }),
	        image:new ol.style.Circle({
	            radius:7,
	            fill:new ol.style.Fill({
	                color:'#ffcc33'
	            })
	        })
	    })
	
	    var bbox = []; //地图显示的范围
	    var viewParams = "";
	
	    $(document).ready(function(){		
	    
	    	$("#display").hide();
	        $(".display_vector").hide();
	        $(".dataSelectionAddTitle").hide();
	        
	        //形状下拉框的值
	        var shapeText; //形状下拉框的值默认是矩形
			var sum_area ; //面积
			var selectionYear = [];//选择的年份
			
			//年份
			$(".ui.year.dropdown").dropdown({
				maxSelections:5,
				onAdd:function(addedValue, addedText, $addedChoice){
					//添加数据选项
					selectionYear.push(addedValue);
				},
				onLabelRemove:function(value){
					//移除数据选项
					selectionYear.splice($.inArray(value,selectionYear), 1);
				}
			})
			
			
			//形状选择
			$(".ui.shapeSelection.dropdown").dropdown({
				onChange:function(value, text, $choice){
					 shapeText = text;
					 map.removeInteraction(draw);
					 addInteraction(value, vector);
				     draw.on('drawend',function(e){
		                var geometrty = e.feature.getGeometry();
		                sum_area = calcArea(value, geometrty)
		            },this);
				}
			});
			
			//产品类型
			var productType ="special";
			//下拉框最多能选几个
			var maxSelections = 1;
			//数据选项
			var indexs = [];
			
			//产品类型
			$(".ui.productType.dropdown").dropdown({
				onChange:function(value, text, $choice){
					productType = value;
					
					//清空数据选项的下拉框
					$(".ui.dataSelection.dropdown").dropdown("clear");
					//清空数组
					indexs.splice(0,indexs.length);
					
					//当产品类型是专题图的话，只有一个选项
					if(value == "special"){
						maxSelections = 1;
						$(".dataSelectionAddTitle").show();
						//数据选项(index)
						$(".ui.dataSelection.dropdown").dropdown({
							maxSelections:maxSelections,
							onAdd:function(addedValue, addedText,  $addedChoice){
								indexs.push(addedValue);
							},
							onLabelRemove:function(value){
								indexs.splice($.inArray(value, indexs), 1);
							}
						})
					}else{
						maxSelections = 10;
						$(".dataSelectionAddTitle").show();
						//数据选项(index)
						$(".ui.dataSelection.dropdown").dropdown({
							maxSelections:maxSelections,
							onAdd:function(addedValue, addedText,  $addedChoice){
								indexs.push(addedValue);
							},
							onLabelRemove:function(value){
								indexs.splice($.inArray(value, indexs), 1);
							}
						})
					}
				}
			});
			
			
			
	
	        
	        //var typeSelect = $("#type");
	        //var value = typeSelect[0].value;
	        //下拉框选择变化时画图
	       // typeSelect.on("change", function(){
	        //    map.removeInteraction(draw);
	        //    value = typeSelect[0].value;
	        //    addInteraction(value, vector);
	       //     draw.on('drawend',function(e){
	       //         var geometrty = e.feature.getGeometry();
	       //         sum_area = calcArea(value, geometrty)
	       //     },this)
	       // })
	       // addInteraction(value, vector);
	       // draw.on('drawend',function(e){
	        //    var geometry = e.feature.getGeometry();
	       //     sum_area = calcArea(value, geometry);
	       // },this)
	
	        //指标数组
	        var result_special_layer = [];
	        //下一步
	        $("#next").on("click",function () {
	        	$.ajax({
	        		url:"home/isLogin.html",
	        		success:function(result){
	        			if(result.islogin){
	        				//已经登录	
	        				display_front(sum_area, indexs, selectionYear, shapeText);
	        			}else{
	        				//没有登录，就跳转到登录界面
	        				$(window).attr("location", "home/login.html");
	        			}
	        		}
	        	})
	           // display_front(sum_area, indexs, selectionYear, shapeText);
	        })    
	        
	        //上一步
	        $("#previous").on("click", function(){
	        	$("#order").show();
	        	$("#display").hide();
	        	//移除专题图中所有的结果
	        	for(var i=0; i < result_special_layer.length; i++){
	        		$("div.description").children().remove();
	        	}
	        	
	        	result_special_layer.splice(0,result_special_layer.length);
	        })
	        
	        //创建订单
	        $("#createOrder").on("click", function(){
	        	var year = selectionYear.join(",");
	        	var indexsString = indexs.join(",");
	        	
	        	var commitParam = {"year":year, "area":sum_area, "index":indexsString, "inputForm":productType};
	        	//提交订单
	        	$(location).attr("href","home/createOrder.html?"+$.param(commitParam));
	        	//重定向到创建订单成功的页面
	        	//$(window).attr("location", "home/createOrderSuccess.html");
	        })
	
	        //专题图
	        $(".resultSpecial").on("click", function(){
        		$(".ui.modal").modal({
        			offset:600,
        			onApprove:function(){
        				$("#display").show();
        				return true;
        			}
        		}).modal('show');
	            result_special(value, indexs, result_special_layer);
	        })
	        
	        
	        //矢量数据
	        $(".resultVector").on("click",function(){
	        	for(var i=0; i<indexs.length; i++){
	        		$(".selection .menu").append("<div class='item' data-value='"+indexs[i]+"'>"+indexs[i]+"</div>");
	        	}
       			//选择之前把先前的移除掉
       			$(".display_vector .result_display_vector").text("");
	        	result_vector(value, indexs);
	        })
	        
	        //矢量数据返回
	         $(".back_vector").on("click", function(){
	        	$("#display").show();
	        	$(".display_vector").hide();
	        	//移除子元素
	        	$(".display_vector .result_display_vector").text("");
	        })
	
	    })
	
	</script>
	
  </body>
</html>
