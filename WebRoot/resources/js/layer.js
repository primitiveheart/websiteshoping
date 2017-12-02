var projection = ol.proj.get("EPSG:3857");
//var projection = ol.proj.get("EPSG:4326");
var resolutions = [];
for(var i=0; i<19; i++){
    resolutions[i] = Math.pow(2, 18-i);
}
var tilegrid  = new ol.tilegrid.TileGrid({
    origin: [0,0],
    resolutions: resolutions
});

var baidu_source = new ol.source.TileImage({
    projection: projection,
    tileGrid: tilegrid,
    tileUrlFunction: function(tileCoord, pixelRatio, proj){
        if(!tileCoord){
            return "";
        }
        var z = tileCoord[0];
        var x = tileCoord[1];
        var y = tileCoord[2];

        if(x<0){
            x = "M"+(-x);
        }
        if(y<0){
            y = "M"+(-y);
        }

        return "http://online3.map.bdimg.com/onlinelabel/?qt=tile&x="+x+"&y="+y+"&z="+z+"&styles=pl&udt=20151021&scaler=1&p=1";
        }
    });



  var layers = [
	new ol.layer.Tile({
      source: baidu_source
    }),
    new ol.layer.Tile({
      source: new ol.source.TileWMS({
	        url: "http://47.93.237.6:8080/map/census_china/wms",
		    params: {'LAYERS': 'census_china:china_county', 'TILED': true},
		    serverType: 'geoserver'
      })
    })
  ];
  
