class ONFOCUS_EVENT extends Event {
	function onUpTime(this_event) {
		if(enable) {
			local eventlayer = layermanager.getLayer(EVENT_LAYER_NUM);
			local objectlayer = layermanager.getLayer(OBJECT_LAYER_NUM);
			local trigger = objectlayer.getObject("Sea Ice Big", 1);//eventlayer.getEventManager().getEventBlock(1);
			if(trigger.collidesWith(bear) && director.getCameraTrace() == bear) {
				local focus = eventlayer.getEventManager().getEventBlock(2);
				director.setCameraTrace(focus);
			}
			local trigger_2 = eventlayer.getEventManager().getEventBlock(1);
			if(trigger_2.collidesWith(bear) && director.getCameraTrace() != bear) {
				director.setCameraTrace(bear);
			}
			local trigger_3 = eventlayer.getEventManager().getEventBlock(3);
			if(trigger_3.collidesWith(bear) && director.getCameraTrace() != bear) {
				director.setCameraTrace(bear);
			}
		}
	}
}

class FINISH_EVENT extends Event {
	fish = null;
	function setFish(_fish) {
		fish = _fish;
	}
	function onUpTime(this_event) {
		if(enable) {
			if(fish != null) {
				if(bear.collidesWith(fish) && fish.alpha() > 0) {
					fish.hide();
					director.SuccessGame();
					//print("Finish!");
				}
			}
		}
	}
}


class Test {
	background = SpriteLayer("background.png", false, 0, 0, 0);
    cloud = TMXLayer("level101.tmx", 1, "cloud_chip.png", MAP_BLOCK_SIZE, 0, 0, 1, 0, 0);
    mountain = TMXLayer("level101.tmx", 2, "mountain_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    ice_back = TMXLayer("level101.tmx", 3, "ice_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    object = ObjectLayer("level101.tmx", 4, "ice_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    ice_front = TMXLayer("level101.tmx", 5, "ice_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    interact = TMXLayer("level101.tmx", 6, "interact_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    event = EventLayer("level101.tmx", 7, "event_chip.png", MAP_BLOCK_SIZE, 0, 0, 0, 0, 0);
    
    wood = createItem(ITEM_COMMON.WOODEN_BOARD);
    rope = createItem(ITEM_COMMON.ROPE);
    
    fish = emo.Sprite("fish.png");
    
    onfocus_event = ONFOCUS_EVENT();
    finish_event = FINISH_EVENT();
	
	function onLoad() {
		layermanager.addObject(background);
		layermanager.addObject(cloud);
		layermanager.addObject(mountain);
		layermanager.addObject(ice_back);
		layermanager.addObject(object);
		OBJECT_LAYER_NUM = 4;
		layermanager.addObject(ice_front);
		layermanager.addObject(interact);
		INTERACT_LAYER_NUM = 6;
		layermanager.addObject(event);
		EVENT_LAYER_NUM = 7;
		
		local MaxWidth = layermanager.getMaxWidth();
		local MaxHeight = layermanager.getMaxHeight();
		local minWidth = layermanager.getminWidth();
		local minHeight = layermanager.getminHeight();
		background.setAppendToParent(0, 0, MaxWidth, MaxHeight, true, false);
		background.setZ(0);
		cloud.setInfiniteScroll(-1, 0);
		cloud.setAppendToParent(0, 0, MaxWidth, MaxHeight, true, false);
		cloud.setZ(10);
		mountain.setZ(20);
		ice_back.setZ(30);
		object.setZ(40);
		object.createObjectFromMap();
		object.color(1, 1, 1, 0);
		ice_front.setZ(50);
		interact.setZ(60);
		interact.color(1, 1, 1, 0);
		interact.createTileFromMap();
		event.setZ(70);
		event.color(1, 1, 1, 0);
		event.createEventBlockFromMap();
		event.addEvent(onfocus_event);
		event.addEvent(finish_event);
		
		local endpoint = director.getEndPoint();
		fish.move(endpoint.x, endpoint.y);
		fish.setZ(40);
		fish.load();
		finish_event.setFish(fish);
		
		ui.getItemMenu().addItem(wood);
		ui.getItemMenu().addItem(rope);
		/*for(local i = 0; i < 8; i++) {
			local WOOD = createItem(ITEM_COMMON.WOODEN_BOARD);
			local ROPE = createItem(ITEM_COMMON.ROPE);
			ui.getItemMenu().addItem(WOOD);
			ui.getItemMenu().addItem(ROPE);
		}*/

		local startpoint = director.getStartPoint();
		//print("X: " + temppoint.x + " Y: " + temppoint.y);
		if(startpoint != null) bear.Init(startpoint.x, startpoint.y - bear.getHeight(), 41);
		
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