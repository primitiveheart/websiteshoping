function result_special(value, indexs, result_layer){
	$("#order").hide();
	$("#display").hide();
	var year = $("#year").val();
	var extent = [71.0, 16.0, 136.0, 55.0];
	//	var extent = bbox;
	
	//viewParams = viewParams + ";fld:gb1999;year_=" + year + ";usr_name:'sha';pwd:'zongyao'";
	var layers = "";
	
	if(value == "Circle") {
		layers = "census_china:getCensusByRadius";
	} else if(value == "Polygon") {
		layers = "census_china:getCensusbyRectangle"
	} else {
		layers = "census_china:getCensusbyRectangle";
	}
	var fld;
	
	for(fld in indexs){
		var viewParams_special = viewParams + ";fld:" +indexs[fld]+ ";year_=" + year + ";usr_name:'sha';pwd:'zongyao'";
		var middle_layer = new ol.layer.Tile({
			extent: extent,
			source: new ol.source.TileWMS({
				url: "http://47.93.237.6:8080/map/census_china/wms",
				params: {
					'LAYERS': layers,
					'VERSION': '1.1.0',
					'TRANSPARENCY': true,
					'VIEWPARAMS': viewParams_special,
					'TILED': true
				},
				serverType: 'geoserver'
			})
		})
		result_layer.push(middle_layer);
	}
	
	var projection = ol.proj.get("EPSG:4326");
	
	var layers_num;
	for(layers_num in result_layer){
		$("div.description").append("<div class='ui massive divider'>"+
				indexs[layers_num]+"</div><div id='"+layers_num+"'></div>");
		var middle = layers_num + ""; 
		var map = new ol.Map({
			layers: [result_layer[layers_num]],
			target: middle,
			view: new ol.View({
				center: ol.extent.getCenter(extent),
				projection: projection,
				zoom: 4
			}),
		})
	}
//		if(layers_num % 4 == 0){
//			$(".zero").text(indexs[layers_num]);
//			var map = new ol.Map({
//				layers: [result_layer[layers_num]],
////				target: "'"+layers_num+"'",
//				target: '0',
////				target: 'select_area_map',
//				view: new ol.View({
//					center: ol.extent.getCenter(extent),
//					projection: projection,
//					zoom: 4
//				}),
//			})
//		}else if(layers_num % 4 == 1){
//			$(".one").text(indexs[layers_num]);
//			var map1 = new ol.Map({
//				layers: [result_layer[layers_num]],
////				target: "'"+layers_num+"'",
//				target: '1',
////				target: 'select_area_map',
//				view: new ol.View({
//					center: ol.extent.getCenter(extent),
//					projection: projection,
//					zoom: 4
//				}),
//			})
//		}else if(layers_num % 4 == 2){
//			$(".two").text(indexs[layers_num]);
//			var map2 = new ol.Map({
//				layers: [result_layer[layers_num]],
////				target: "'"+layers_num+"'",
//				target: '2',
////				target: 'select_area_map',
//				view: new ol.View({
//					center: ol.extent.getCenter(extent),
//					projection: projection,
//					zoom: 4
//				}),
//			})
//		}else{
//			$(".three").text(indexs[layers_num]);
//			var map3 = new ol.Map({
//				layers: [result_layer[layers_num]],
////				target: "'"+layers_num+"'",
//				target: '3',
////				target: 'select_area_map',
//				view: new ol.View({
//					center: ol.extent.getCenter(extent),
//					projection: projection,
//					zoom: 4
//				}),
//			})
//		}
}
