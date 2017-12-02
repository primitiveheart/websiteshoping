function result_vector(value, indexs){
	$("#display").hide();
	$(".display_vector").show();
	var typeName = "";
	var year = $("#year").val();
	var all_index = "";
	if(indexs.length != 1){
		all_index = indexs.join(",")
	}else{
		all_index = indexs;
	}
	var viewParams_vector = viewParams + ";fld:" +all_index+ ";year_=" + year + ";usr_name:'sha';pwd:'zongyao'";
	if(value == "Circle") {
		typeName = "census_china:getCensusByRadius";
	} else if(value == "Polygon") {
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
//      	$(".display_vector .container").append("<table class='ui small celled table'><thead><tr><th>名字</th><th>坐标</th></tr></thead><tbody></tbody></table>");
//      	$(result).find(":first").find(":first").children().each(function(){
//      		var name = $(this).children(":nth(1)").text();
//      		var posList = $(this).find(":first").find(":first").find(":first").find(":first").find(":first").text();
//      		$(".display_vector .container table tbody").append("<tr><td>" +name +"</td><td>"+posList+"</td></tr>");
//      	})
      },  
      error: function(){  
        alert("执行失败");    
      }  
  });  
}