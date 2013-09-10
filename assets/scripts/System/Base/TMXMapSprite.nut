class TMXMapSprite extends emo.MapSprite {
	tmxname = null;
	layernum = 0;
	chipname = null;
	chipsize = 0;
	border = 0;
	margin = 0;
    rawname = null;
    mapdata = null;
    firstgid = null;
    function constructor(_tmxname, _layernum, _chipname, _chipsize, _border, _margin) {
    	base.constructor(_chipname, _chipsize, _chipsize, _border, _margin);
    	tmxname = _tmxname;
    	layernum = _layernum;
    	chipname = _chipname;
    	chipsize = _chipsize;
    	border = _border;
    	margin = _margin;
    	
    	// load tmx file from graphics folder
        rawname = ANDROID_GRAPHICS_DIR + tmxname;
        mapdata = stage.getMapData(rawname);
        for(local i = 0; i < mapdata.layer.len() ; i++) {
        	if(mapdata.tileset[i].source == chipname) {
        		firstgid = mapdata.tileset[i].firstgid.tointeger();
        		local newlayer = mapdata.layer[layernum];
        		
        		//local line = "";
        		for(local oned = 0; newlayer.data.len() > oned ; oned++){
		            for(local twod = 0; newlayer.data[oned].len() > twod ; twod++){
		            	local tileddata = newlayer.data[oned][twod].tointeger();
		            	if(newlayer.data[oned][twod] != -1) newlayer.data[oned][twod] = tileddata - firstgid + 1;
		                //line += format("%02d", newlayer.data[oned][twod]);
		                /*if(twod != newlayer.data[oned].len()){
		                    line += " ";
		                }*/
		            }
		            //print(oned + " : " + line);
		        }
        		this.useMeshMapSprite(true);
        		this.setMap(newlayer.data);
        		break;
        	}
        }   
    }
    function getFirstgid() {
    	return firstgid;
    }
    function getChipname() {
    	return chipname;
    }
    function getTileCoordAtIndex(x, y) {
    	local coord_x = 0;
    	local coord_y = 0;
    	if(x <= mapdata.layer[layernum].width) coord_x = chipsize*x;
    	else print("ERROR: Index X out of bound");
    	if(y <=  mapdata.layer[layernum].height) coord_y = chipsize*y;
    	else print("ERROR: Index Y out of bound");
    	
    	return emo.Vec2(coord_x, coord_y);
    }
    function getColCount() {
    	return mapdata.layer[layernum].width;
    }
    function getRowCount() {
    	return mapdata.layer[layernum].height;
    }
    function getChipSize() {
    	return chipsize;
    }
    /*
	 * function for showing specific layer contents in tmx file.
	 */
	function printLayerData(){
	    print(tmxname + ", " + "layer " + layernum + ": ");
	        print("name : " + mapdata.layer[layernum].name);
	        print("width : " + mapdata.layer[layernum].width);
	        print("height : " + mapdata.layer[layernum].height);
	        print("data : ");
	        
	        for(local oned = 0; mapdata.layer[layernum].data.len() > oned ; oned++){
	            local line = "";
	            for(local twod = 0; mapdata.layer[layernum].data[oned].len() > twod ; twod++){
	                line += format("%02d", mapdata.layer[layernum].data[oned][twod]);
	                if(twod != mapdata.layer[layernum].data[oned].len()){
	                    line += " ";
	                }
	            }
	            print(oned + " : " + line);
	        }
	}
    
    /*
	 * function for testing tmx file contents.
	 */
	function printTMXData(){
	    print("mapdata : " + mapdata);
	    print("tileset : ");
	    for(local i = 0; i < mapdata.tileset.len() ; i++){
	        print("firstgid : " + mapdata.tileset[i].firstgid);
	        print("name : " + mapdata.tileset[i].name);
	        print("tilewidth : " + mapdata.tileset[i].tilewidth);
	        print("tileheight : " + mapdata.tileset[i].tileheight);
	        print("source : " + mapdata.tileset[i].source);
	        print("trans : " + mapdata.tileset[i].trans);
	        print("width : " + mapdata.tileset[i].width);
	        print("height : " + mapdata.tileset[i].height);
	    }
	    
	    print("layer : ");
	    for(local i = 0; i < mapdata.layer.len() ; i++){
	        print("name : " + mapdata.layer[i].name);
	        print("width : " + mapdata.layer[i].width);
	        print("height : " + mapdata.layer[i].height);
	        print("data : ");
	        
	        for(local oned = 0; mapdata.layer[i].data.len() > oned ; oned++){
	            local line = "";
	            for(local twod = 0; mapdata.layer[i].data[oned].len() > twod ; twod++){
	                line += format("%02d", mapdata.layer[i].data[oned][twod]);
	                if(twod != mapdata.layer[i].data[oned].len()){
	                    line += " ";
	                }
	            }
	            print(oned + " : " + line);
	        }
	    }
	}
}