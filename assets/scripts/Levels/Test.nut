class Test {
	background = SpriteLayer("background.png", false, 0, 0, 0);
    cloud = TMXLayer("level101.tmx", 1, "cloud_chip.png", MAP_BLOCK_SIZE, 0, 0, 1, 0, 0);
    mountain = TMXLayer("level101.tmx", 2, "mountain_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    ice_back = TMXLayer("level101.tmx", 3, "ice_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    object = TMXLayer("level101.tmx", 4, "ice_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    ice_front = TMXLayer("level101.tmx", 5, "ice_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    interact = TMXLayer("level101.tmx", 6, "interact_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    
    wood = createItem(ITEMICE.WOODEN_BOARD);
    rope = createItem(ITEMICE.ROPE);
	
	function onLoad() {
		layermanger.addObject(background);
		layermanger.addObject(cloud);
		layermanger.addObject(mountain);
		layermanger.addObject(ice_back);
		layermanger.addObject(object);
		layermanger.addObject(ice_front);
		layermanger.addObject(interact);
		
		local MaxWidth = layermanger.getMaxWidth();
		local MaxHeight = layermanger.getMaxHeight();
		local minWidth = layermanger.getminWidth();
		local minHeight = layermanger.getminHeight();
		background.setAppendToParent(0, 0, interact.getWidth(), interact.getHeight(), true, false);
		background.setZ(0);
		cloud.setInfiniteScroll(-1, 0);
		cloud.setAppendToParent(0, 0, interact.getWidth(), interact.getHeight(), true, false);
		cloud.setZ(10);
		mountain.setZ(20);
		ice_back.setZ(30);
		object.setZ(40);
		ice_front.setZ(50);
		interact.setZ(60);
		interact.color(1, 1, 1, 0);
		interact.createTileFromMap();
		
		for(local i = 0; i < 8; i++) {
			local WOOD = createItem(ITEMICE.WOODEN_BOARD);
			local ROPE = createItem(ITEMICE.ROPE);
			ui.getItemMenu().addItem(WOOD);
			ui.getItemMenu().addItem(ROPE);
		}

		local temppoint = director.getStartPoint();
		//print("X: " + temppoint.x + " Y: " + temppoint.y);
		if(temppoint != null) bear.Init(temppoint.x, temppoint.y - bear.getHeight() - 10, 41);
		
		Stage_Visible_Width = interact.getWidth();
		Stage_Visible_Height = interact.getHeight();
		
		director.setCameraTrace(bear);
		
		director.onLoad();
	}
	function onDrawFrame(dt) {
		bear.onGameLoop();
		
		director.onDrawFrame(dt);
	}
	function onFps(fps) {
		director.onFps(fps);
	}
	function onLowMemory() {
		director.onLowMemory();
	}
	function onGainedFocus() {
		director.onGainedFocus();
	}
	function onLostFocus() {
		director.onLostFocus();
	}
	function onDispose() {
		director.onDispose();
	}
	function onSensorEvent(sevent) {
		director.onSensorEvent(sevent);
	}
	function onMotionEvent(mevent) {
		director.onMotionEvent(mevent);
	}
	function onKeyEvent(kevent) {
		director.onKeyEvent(kevent);
	}
	function onContact(state, fixtureA, fixtureB, 
            position, normal, normalImpulse, tangentImpulse) {
    	director.onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
   	}
   	function onImpact(fixtureA, fixtureB,
            position, normal, normalImpulse, tangentImpulse) {
    	bear.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
    	
    	director.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
    }
}

Current_Level_Function = Test();