class TextSprite {
    textbase = null;
    indexes = null;
    textTiles = null;
    backFrame = null;
    backFrame_border = 0;
    
    loaded   = null;
    uptime   = null;
    
    physicsInfo = null;
    
    isGui = false;
    
    x = 0;
    y = 0;
    z = 0;
    
    r = 1;
    g = 1;
    b = 1;
    a = 1;
    
    visible = false;
    
    name = null;
    rawname = null;
    width = 0;
    height = 0;
    border = 0;
    margin = 0;
    
    function constructor(_rawname, _textbase, _width, _height, _border = null, _margin = null) {
    	x = 0;
   		y = 0;
    	z = 0;
    
    	r = 1;
    	g = 1;
    	b = 1;
    	a = 1;
    	
        textbase = _textbase;
        textTiles = [];
        indexes = [];
        
        rawname = _rawname;
        name = this.getResourceName(_rawname);
        width = _width;
        height = _height;
        border = _border;
        margin = _margin;
        //base.constructor(_rawname, _width, _height, _border, _margin);
        loaded = false;
    }
    
    function getResourceName(_rawname) {
        if (_rawname == null) return null;
        if (runtime.os() == OS_ANDROID) {
            _rawname = ANDROID_GRAPHICS_DIR + _rawname;
        }
        return _rawname;
    }
    
    function setText(text) {
        text = text.tostring();
        indexes.clear();
        for (local i = 0; i < text.len(); i++) {
            local idx = textbase.find(text.slice(i, i+1));
            if (idx == null) idx = -1;
            indexes.append(idx);
        }
        this.clearTextTiles();
        this.addTextTiles(indexes);
    }
    
    function addBackFrame(border = 0) {
    	backFrame_border = border;
    	
    	backFrame = emo.Rectangle();
    	backFrame.setSize(this.getWidth() + border*2, this.getHeight() + border*2);
    	//backFrame.load();
    	backFrame.color(r, g, b, a);
    	//stage.color(backFrame.getId(), _r, _g, _b, _alpha);
    	//backFrame.alpha(_alpha);
    	backFrame.setZ(z-1);
    	if(isGui) backFrame.setAsGui();
    	backFrame.move(x, y);
    	
    	this.move(x, y);
    	
    	if(loaded) backFrame.load();
    }
    
    /*function loadBackFrame() {
    	backFrame.load();
    }*/
    
    function removeBackFrame() {
    	backFrame.remove();
    	backFrame = null;
    	backFrame_border = 0;
    }
    
    function setBackFrame(_r, _g, _b, _alpha = null, border = 0) {
    	backFrame.setSize(this.getWidth() + border*2, this.getHeight() + border*2);
    	backFrame.color(_r, _g, _b, _alpha);
    	//stage.color(backFrame.getId(), _r, _g, _b, _alpha);
    	this.move(x, y);
    }
    
    function moveBackFrame(_x, _y) {
    	backFrame.move(_x, _y);
    }
    
    function hideBackFrame() {
    	backFrame.hide();
    }
    
    function showBackFrame() {
    	backFrame.show();
    }
    
    function getBackFrame() {
    	return backFrame;
    }
    
    function addTextTiles(indexes) {
    	for(local i=0; i<indexes.len(); i++) {
    		local tempTextTile = emo.SpriteSheet(rawname, width, height, border, margin, 0);
    		tempTextTile.load();
    		tempTextTile.setFrame(indexes[i]);
    		//tempTextTile.move(x + width*i, y);
    		if(visible) tempTextTile.show();
    		else if(!visible) tempTextTile.hide();
    		tempTextTile.color(r, g, b, a);
    		if(isGui) tempTextTile.setAsGui();
    		tempTextTile.setZ(z);
    		textTiles.append(tempTextTile);
    		//textTiles_ids.append(tempTextTile.getId());
    	}
    	this.move(x, y);
    }
    
    /*function retainFromCamera(camera_x, camera_y) {
    	/*local new_x = x + camera_x;
    	local new_y = y + camera_y;
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].move(new_x + width*i, new_y);
        local stageZoomWidth = stage.getWindowWidth() / stage.getZoomRatio();
        local stageZoomHeight = stage.getWindowHeight() / stage.getZoomRatio();
        local camera_zoomRatio = stage.getZoomRatio();
        
        this.move((stageZoomWidth - this.getWidth())/2 + camera_x, (stageZoomHeight - this.getHeight()) + camera_y);
    	//this.scale(1.0/camera_zoomRatio, 1.0/camera_zoomRatio);
    	//this.move((stageZoomWidth - this.getWidth())/2 + camera_x, (stageZoomHeight - this.getHeight()) + camera_y);
    }*/
    
    function load() {
    	if(!loaded) {
	    	if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++) {
	        	if(textTiles[i]!=null) textTiles[i].load();
	        	//print(format("i: %d, x: %d, y: %d, z: %d, r: %d, g: %d, b: %d, a: %d", i, textTiles[i].getX(), textTiles[i].getY(), textTiles[i].getZ(), textTiles[i].red(), textTiles[i].green(), textTiles[i].blue(), textTiles[i].alpha()));
	    	}
	        if(backFrame != null) backFrame.load();
	        visible = true;
	        uptime = EMO_RUNTIME_STOPWATCH.elapsed();
	        loaded = true;
    	}
    }
    
    function move(_x, _y) {
    	x = _x;
    	y = _y;
    	//local stageZoomWidth = stage.getWindowWidth() / stage.getZoomRatio();
        //local stageZoomHeight = stage.getWindowHeight() / stage.getZoomRatio();
        //local camera_zoomRatio = stage.getZoomRatio();
    	
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null)
        		if(i == 0) textTiles[i].move(x + backFrame_border, y + backFrame_border);
        		else textTiles[i].move(textTiles[i-1].getX() + textTiles[i-1].getWidth(), textTiles[i-1].getY());
        
        if(backFrame != null) backFrame.move(x, y);
    }
    
    function show() {
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].show();
        	
        if(backFrame != null) backFrame.show();
        
        visible = true;
    }
    
    function hide() {
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].hide();
        	
        if(backFrame != null) backFrame.hide();
        
        visible = false;
    }
    
    function isLoaded() { return loaded; }
    
    function getWidth() {
    	if(backFrame != null && backFrame.getWidth() != 0) return backFrame.getWidth();
    	else {
	    	local temp_width = 0;
	    	if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++)
	        	if(textTiles[i]!=null) temp_width += textTiles[i].getWidth();
	        return temp_width;
    	}
    }
    
    function getHeight() {
    	if(backFrame != null && backFrame.getHeight() != 0) return backFrame.getHeight();
    	return height;
    }
    
    function clearTextTiles() {
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].remove();
    	textTiles.clear();
    	//textTiles_ids.clear();
    }
    
    function remove() {
    	if (loaded) {
    		
    		if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++)
	        	if(textTiles[i]!=null) textTiles[i].remove();
	    	textTiles.clear();
	    	//textTiles_ids.clear();
	    	indexes.clear();
    	
    		if(backFrame != null) this.removeBackFrame();
    		
            this.clearModifier();
            emo.Event.removeMotionListener(this);
            if (physicsInfo != null) {
                physicsInfo.remove();
                physicsInfo = null;
            }
            loaded = false;
        }
		return null;
    }
    
    function setZ(_z) {
    	z = _z;
    	
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].setZ(z);
        	
        if(backFrame != null) backFrame.setZ(z-1);
    }
    
    function color(_r, _g, _b, _alpha = null) {
    	r = _r;
    	g = _g;
    	b = _b;
    	if(_alpha != null) a = _alpha;
    	
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].color(r, g, b, a);
        	
        if(backFrame != null) backFrame.color(r, g, b, a);
    }
    
    function alpha(_alpha = null) {
    	if(_alpha == null) return a;
    	else {
    		a = _alpha;
    	
	    	if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++)
	        	if(textTiles[i]!=null) textTiles[i].alpha(a);
	        	
	        if(backFrame != null) backFrame.alpha(a);
    	}
    }
    
    function red(_r = null) {
    	if(_r == null) return r;
    	else {
    		r = _r;
    	
	    	if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++)
	        	if(textTiles[i]!=null) textTiles[i].red(r);
	        	
	        if(backFrame != null) backFrame.red(r);
    	}
    }
    
    function green(_g = null) {
    	if(_g == null) return g;
    	else {
    		g = _g;
    	
	    	if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++)
	        	if(textTiles[i]!=null) textTiles[i].green(g);
	        	
	        if(backFrame != null) backFrame.green(g);
    	}
    }
    
    function blue(_b = null) {
    	if(_b == null) return b;
    	else {
    		b = _b;
    	
	    	if(textTiles != null)
	    	for(local i=0; i<textTiles.len(); i++)
	        	if(textTiles[i]!=null) textTiles[i].blue(b);
	        	
	        if(backFrame != null) backFrame.blue(b);
    	}
    }
    
    function getX() {
    	return x;
    }
    
    function getY() {
    	return y;
    }
    
    function getZ() {
    	return z;
    }
    
    function getCenterX() {
    	return x + getWidth()/2;
    }
    
    function getCenterY() {
    	return y + getHeight()/2;
    }
    
    function scale(scaleX, scaleY) {
    	for(local i=0; i<textTiles.len(); i++)
        	stage.scale(textTiles[i].getId(), scaleX, scaleY, 0, 0);
        //move(x, y);
        //return stage.scale(textTiles[0].getId(), scaleX, scaleY, 0, 0);
        if(backFrame != null) stage.scale(backFrame.getId(), scaleX, scaleY, 0, 0);
    }
    
    function getScaleX() {
        if(textTiles != null && textTiles.len() > 0) return stage.getScaleX(textTiles[0].getId());
        else return 1;
    }
    
    function getScaleY() {
        if(textTiles != null && textTiles.len() > 0) return stage.getScaleY(textTiles[0].getId());
        else return 1;
    }
    
    function getScaledWidth() {
    	if(backFrame != null) return backFrame.getWidth() * backFrame.getScaleX();
        else return getWidth() * getScaleX();
    }
    
    function getScaledHeight() {
    	if(backFrame != null) return backFrame.getHeight() * backFrame.getScaleY();
        else return getHeight() * getScaleY();
    }
    
    function contains(_x, _y) {
    	local flag = false;
    	if(backFrame != null) if(backFrame.contains(_x, _y)) flag = true;
    	else {
	    	for(local i=0; i<textTiles.len(); i++) {
	    		if(textTiles[i].contains(_x, _y)) {
	    			flag = true;
	    			break;
	    		}
	    	}
    	}
    	return flag;
    }

    function collidesWith(_other) {
        local flag = false;
    	if(backFrame != null) if(backFrame.collidesWith(_other)) flag = true;
    	else {
	    	for(local i=0; i<textTiles.len(); i++) {
	    		if(textTiles[i].collidesWith(_other)) {
	    			flag = true;
	    			break;
	    		}
	    	}
    	}
    	return flag;
    }
    
    function addModifier(modifier, startTime = null) {
        if (startTime != null) modifier.startTime = startTime;

        modifier.setObject(this);
        emo.Event.addOnUpdateListener(modifier);
    }

    function removeModifier(modifier) {
        emo.Event.removeOnUpdateListener(modifier);
    }
    
    function clearModifier() {
        emo.Event.removeOnUpdateListenerForObject(this);
    }
    
    function setPhysicsInfo(_physicsInfo) {
        physicsInfo = _physicsInfo;
    }
    
    function getPhysicsInfo() {
        return physicsInfo;
    }
    
    function getFixture() {
        if (physicsInfo == null) return null;
        return physicsInfo.getFixture();
    }
    
    function getPhysicsBody() {
        if (physicsInfo == null) return null;
        return physicsInfo.getBody();
    }
    
    function elapsed() {
        if (uptime == null) return -1;
        return EMO_RUNTIME_STOPWATCH.elapsed() - uptime;
    }

    function blendFunc(sfactor, dfactor) {
    	for(local i=0; i<textTiles.len(); i++)
        	stage.blendFunc(textTiles[i].getId(), sfactor, dfactor);
    }
    
    function setAsGui() {
    	if(textTiles != null)
    	for(local i=0; i<textTiles.len(); i++)
        	if(textTiles[i]!=null) textTiles[i].setAsGui();
        	
        if(backFrame != null) backFrame.setAsGui();
        
        isGui = true;
    }
}