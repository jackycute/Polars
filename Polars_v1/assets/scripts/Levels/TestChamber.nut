/*
 * This example shows tiled map sprite.
 */
class TestChamber {

    //controller = emo.AnalogOnScreenController("control_base.png", "control_knob.png");
    controlX = 0;
    controlY = 0;
    lastDirection = CONTROL_CENTER;
    
    // get center coordinate of screen
    centerX = 0;
    centerY = 0;
    
    zoomIn = emo.Sprite("zoom_in.png");
    zoomInEnabled = true;
    zoomOut = emo.Sprite("zoom_out.png");
    zoomOutEnabled = true;
    
    nextlevel = emo.Sprite("nextlevel.png");
    replay = emo.Sprite("replay.png");
    
    // create map sprite with 32x32, 2 pixel border and 2 pixel margin
    map = TMXMapSprite("desert.tmx", 0, "desert_chips.png", MAP_BLOCK_SIZE, 1, 1);
    //emo.MapSprite("desert_chips.png", MAP_BLOCK_SIZE, MAP_BLOCK_SIZE, 1, 1);
    //bear = emo.SpriteSheet("bear.png", 34, 42, 1, 1);
    
    //bear_idle_timer = BEAR_IDLE_TIMER(2000, 1000, 1000.0/fps);
    tv = emo.physics.CircleShape();
    
    ball_fixtureDef = emo.physics.FixtureDef();
    ball_bodyDef = emo.physics.BodyDef();
    
    ball = null;
    
    stone_fixtureDef = emo.physics.FixtureDef();
    stone_bodyDef = emo.physics.BodyDef();
    
    //stone_physics_array = [];
    //stone = emo.Rectangle();
    
    wallN  = emo.Rectangle();
    wallS  = emo.Rectangle();
    wallE  = emo.Rectangle();
    wallW  = emo.Rectangle();
    
    /*
     * Called when this class is loaded
     */
    function onLoad() {
        //stage.setContentScale(stage.getWindowWidth() / 720.0);
        stage.setContentScale(stage.getWindowHeight() / 480.0);
        
        bear.Init();
 
        ball = emo.Sprite("softcircle.png");
    	//ball.setSegmentCount(emo.LiquidSprite.CIRCLE);
        
        // get center coordinate of screen
        centerX = stage.getWindowWidth()   / 2;
        centerY = stage.getWindowHeight()  / 2;
        
        // set zoom icons as unmoving objects
        zoomIn.setAsGui();
        zoomOut.setAsGui();
        replay.setAsGui();
        nextlevel.setAsGui();
        
        tv.radius(50);
        tv.position(emo.Vec2(50, 50));
        //tv.move(centerX, centerY);
        //physics.createDynamicSprite(world, tv, ball_fixtureDef, ball_bodyDef);
        //tv.load();
        
        createObjectFromMap(map);
        //map.printTMXData();
        //map.printLayerData();
        /*// load tmx file from graphics folder
        local rawname = ANDROID_GRAPHICS_DIR + "desert.tmx";
        local mapdata = stage.getMapData(rawname);
        map.useMeshMapSprite(true);
        map.setMap(mapdata.layer[1].data);*/
        
        //printData(mapdata);
        // onControlEvent is fired every 16 milliseconds at most
        // the default updateInterval equals 100 milliseconds
        //controller.updateInterval = 16;
        
        // set size of objects which don't have sprites
        wallN.setSize(map.getWidth(), 20);
        wallS.setSize(map.getWidth(), 20);
        wallE.setSize(20, map.getHeight());
        wallW.setSize(20, map.getHeight());
        
        // move sprite to the center of the screen
        
    	/*controller.move((stage.getWindowWidth() - controller.getWidth()) / 2,
                         stage.getWindowHeight() - controller.getHeight());*/
        zoomIn.move(stage.getWindowWidth() - zoomIn.getWidth() - zoomOut.getWidth(), 0);
        zoomOut.move(stage.getWindowWidth() - zoomOut.getWidth(), 0 );
        
        replay.move(zoomIn.getX() - replay.getWidth(), 0);
        nextlevel.move(replay.getX() - nextlevel.getWidth(), 0);
        map.move(0, 0);
        
        ball.move(0 + ball.getWidth(), bear.getY() - ball.getHeight());
        
        wallN.move(0, 0);
        wallS.move(0, map.getHeight() - wallS.getHeight());
        wallE.move(0, 0);
        wallW.move(map.getWidth()  - wallW.getWidth(), 0);
        
        // set Z-Order
        //controller.setZ(80);
        zoomIn.setZ(80);
        zoomOut.setZ(80);
        nextlevel.setZ(80);
        replay.setZ(80);
        ball.setZ(20);
        
        wallN.setZ(20);
        wallS.setZ(20);	
        wallE.setZ(20);
        wallW.setZ(20);
        map.setZ(10);
        
        // set up physics
        physics.createStaticSprite(world, wallN);
        physics.createStaticSprite(world, wallS);
        physics.createStaticSprite(world, wallE);
        physics.createStaticSprite(world, wallW);
        
        ball_fixtureDef.density  = 1.0;
        ball_fixtureDef.friction = 0.3;
        ball_fixtureDef.restitution = 0.2;
        
        physics.createDynamicCircleSprite(world, ball, ball.getWidth() * 0.5, ball_fixtureDef, ball_bodyDef);
        //physics.createSoftCircleSprite(world, ball, ball_fixtureDef, true);
                
        // load sprites to the screen
        //controller.load();
        
        replay.alpha(0.5);
        nextlevel.alpha(0.5);
        
        replay.load();
        nextlevel.load();
        
        zoomIn.load();
        zoomOut.load();
        map.load();
        
        ball.load();
        wallN.load();
        wallS.load();
        wallE.load();
        wallW.load();
        for(local i=0; i<stone_array.len(); i++)
        	if(stone_array[i]!=null && !stone_array[i].isLoaded()) stone_array[i].load();
        
        // set OnDrawCallback interval (millisecond)
        emo.Event.enableOnDrawCallback(1000.0 / fps);
        
        // enable the physics worlds contact listener
        world.enableContactListener();
        
        // in this example we use only add state so disable other status.
        // this will suppress unnecessary event calls.
        world.enableContactState(PHYSICS_STATE_NULL,    false);
        world.enableContactState(PHYSICS_STATE_PERSIST, false);
        world.enableContactState(PHYSICS_STATE_REMOVE,  false);
        world.enableContactState(PHYSICS_STATE_ADD,     true);
        world.enableContactState(PHYSICS_STATE_IMPACT,  true);
        
        sensorDetector.registerSensors();
    }
     
     /*
     * Called when the onDraw callback is enabled by enableOnDrawCallback.
     * This callback is called before drawing the screen at interval of milliseconds set by enableOnDrawCallback.
     * dt is the actual delta time elapsed (milliseconds).
     */
    function onDrawFrame(dt) {
        // world step interval(second)
        world.step(dt / 1000.0, 10, 10);
        //world.setAutoClearForces(dt / 1000.0);
        //world.clearForces();
		bear.onGameLoop();
		
		//print("uptime: " + runtime.uptime());
        /*if(zoomRatio >= 1.5 || zoomRatio <= 0.5) zoomRate = -zoomRate;
        zoomRatio = zoomRatio + zoomRate;
        
        stage.setZoomRatio(zoomRatio);
        //print(stage.getZoomRatio());
        centerX = stage.getWindowWidth() / stage.getZoomRatio() / 2;
        centerY = stage.getWindowHeight() / stage.getZoomRatio() / 2;*/
        //zoomIn.move(centerX, centerY);
        if( zoomRatio >= 1.5 ){
        	zoomInEnabled = false;
            zoomIn.hide();	
        }else if( zoomInEnabled == false ){
            zoomInEnabled = true;
            zoomIn.show();
        }
        
        if( zoomRatio <= 0.5 ){
        	zoomOutEnabled = false;
            zoomOut.hide();
        } else if( zoomOutEnabled == false){
            zoomOutEnabled = true;
            zoomOut.show();	
        }
        
        CameraMoveByStage(bear);
    }
    
    function CameraMoveByStage(sprite) {
    	local BIAS_X = sprite.getCenterX() - centerX;
        local BIAS_Y = sprite.getCenterY() - centerY;
        
        local stageZoomWidth = stage.getWindowWidth() / stage.getZoomRatio();
        local stageZoomHeight = stage.getWindowHeight() / stage.getZoomRatio();
        
        if(stageZoomWidth >= map.getWidth()) BIAS_X = -(stageZoomWidth - map.getWidth()) / 2;
        else if(BIAS_X <= 0) BIAS_X = 0;
        else if(BIAS_X + stageZoomWidth >= map.getWidth()) BIAS_X = map.getWidth() - stageZoomWidth;
        
        if(stageZoomHeight >= map.getWidth()) BIAS_Y = -(stageZoomHeight - map.getHeight()) / 2;
        else if(BIAS_Y <= 0) BIAS_Y = 0;
        else if(BIAS_Y + stageZoomHeight >= map.getHeight()) BIAS_Y = map.getHeight() - stageZoomHeight;
        
        stage.moveCamera(BIAS_X, BIAS_Y);
        Camera_X = BIAS_X;
        Camera_Y = BIAS_Y;
    }

    /*
     * Called when the app has gained focus
     */
    function onGainedFocus() {
        print("onGainedFocus");
		
		//level_name_timer.start();
		
        sensorDetector.enableSensors();
    }

    /*
     * Called when the app has lost focus
     */
    function onLostFocus() {
        print("onLostFocus"); 
        
        //level_name_timer.stop();
        
        sensorDetector.disableSensors();
    }

    /*
     * Called when the class ends
     */
    function onDispose() {
        print("onDispose");
        
        stage.moveCamera(0, 0);
        world.step(30 / 1000.0, 10, 10);
        world.clearForces();
        // remove sprite from the screen
        //controller.remove();
        map.remove();
        /*bear.getPhysicsInfo().remove();
	    bear.physicsInfo = null;
		bear.remove();*/
		nextlevel.remove();
		replay.remove();
		
        ball.getPhysicsInfo().remove();
	    ball.physicsInfo = null;
        ball.remove();
        
        wallN.getPhysicsInfo().remove();
	    wallN.physicsInfo = null;
        wallN.remove();
        
        wallS.getPhysicsInfo().remove();
	    wallS.physicsInfo = null;
        wallS.remove();
        
        wallE.getPhysicsInfo().remove();
	    wallE.physicsInfo = null;
        wallE.remove();
        
        wallW.getPhysicsInfo().remove();
	    wallW.physicsInfo = null;
        wallW.remove();
        
        for(local i=0; i<stone_array.len(); i++)
        	if(stone_array[i]!=null && stone_array[i].isLoaded()) {
        		stone_array[i].getPhysicsInfo().remove();
	        	stone_array[i].physicsInfo = null;
        		stone_array[i].remove();
        		stone_array[i] = null;
        	}
        stone_array.clear();
        sensorDetector.remove();
        gestureDetector.remove();
        
        sensorDetector.disableSensors();
        //emo.Event.disableOnDrawCallback();
    }
    
    /*
     * on-screen controller event
     * controlX and controlY takes value from -100 to 100.
     */
    /*function onControlEvent(controller, _controlX, _controlY, hasChanged) {
        if (hasChanged) {
            controlX = _controlX;
            controlY = _controlY;
            if(controlX != 0){
                controlX /= 5.0;
            }
            if(controlY != 0){
                controlY /= 5.0;
            }
            
            if(controlX == 0 && controlY == 0 && bear.isAnimationFinished() == false){
                bear.pause();
                lastDirection = CONTROL_CENTER;
                return;
            }
            
            if (controlX < 0 && lastDirection != CONTROL_LEFT) {
	                bear.animate(5, 5, 120, -1);
	                lastDirection = CONTROL_LEFT;
            } else if (controlX > 0 && lastDirection != CONTROL_RIGHT ) {
                    bear.animate(0, 5, 120, -1);
                    lastDirection = CONTROL_RIGHT;
            }
        }
    }*/
    function createObjectFromMap(_map) {
    	local coord = _map.getTileCoordAtIndex(_map.getColCount(), _map.getRowCount());
    	//print("getColCount: " + _map.getColCount() + " " + "getRowCount: " + _map.getRowCount());
    	//print("X: " + coord.x + " " + "Y: " + coord.y);
    	
    	for(local y=0; y<_map.getRowCount(); y++) {
    		local line = "";
    		for(local x=0; x<_map.getColCount(); x++) {
    			line += format("%02d", _map.getTileAt(y, x));
    			if(x != _map.getRowCount()-1) line += " ";
    			
    			if(_map.getTileAt(y, x) == 31) {
    				stone_fixtureDef.density = 0.5;
				    stone_fixtureDef.friction = 0.2;
				    stone_fixtureDef.restitution = 0.5;
				                
				    stone_bodyDef.fixedRotation = true;
				   	//stone_bodyDef.linearDamping = 1.0;
				   	//stone_bodyDef.allowSleep = false;
    				
    				local stone = emo.Rectangle();
    				local stone_coord = _map.getTileCoordAtIndex(x, y);
    				//stone.color(1, 1, 1, 1);
    				//stone.hide();
    				stone.setZ(20);
    				stone.setSize(_map.getChipSize(), _map.getChipSize());
    				stone.move(stone_coord.x, stone_coord.y);
    				physics.createStaticSprite(world, stone, stone_fixtureDef, stone_bodyDef);
    				
    				stone_array.append(stone);
    				print("CREATE::STONE" + " " + "SIZE: " + _map.getChipSize() + " " + "X: " + stone_coord.x + " " + "Y: " + stone_coord.y);
    			}
    		}
    		//print(line + "\n");
    	}
    }
    
   	/*
     * sensor event
     */
    function onSensorEvent(sevent) {
    	sensorDetector.onSensorEvent(sevent);
    	
        if (sevent.getType() == SENSOR_TYPE_ACCELEROMETER) {
            
        }
    }
    
    /*
     * touch event
     */
    function onMotionEvent(mevent) {
    	local StageTouch_X = mevent.getX() + Camera_X;
    	local StageTouch_Y = mevent.getY() + Camera_Y;
    	
    	gestureDetector.onMotionEvent(mevent);
    	
        if (mevent.getAction() == MOTION_EVENT_ACTION_DOWN) {
        	if(replay.contains(mevent.getX(), mevent.getY())) {
        		// fade out current scene and move in next scene
				/*local currentSceneModifier = emo.AlphaModifier(1, 0, 1000, emo.easing.Linear);
				local nextSceneModifier = emo.MoveModifier(
				    [0, stage.getWindowHeight()],
				    [0, 0],
				    2000, emo.easing.BackOut);
				stage.load(Director(), currentSceneModifier, nextSceneModifier, false);*/
        		//stage.load(Director());
				LoadScript(Current_Level);
        	}
        	if(nextlevel.contains(mevent.getX(), mevent.getY())) {
        		Current_Level++;
				LoadScript(Current_Level);
        	}
        	
            if(zoomInEnabled == true && 
              (   mevent.getX() > zoomIn.getX() && mevent.getX() < zoomIn.getX() + zoomIn.getWidth()
               && mevent.getY() > zoomIn.getY() && mevent.getY() < zoomIn.getY() + zoomIn.getHeight() ) ){
                zoomRatio += 0.1;
                stage.setZoomRatio(zoomRatio);
                print(stage.getZoomRatio());
                centerX = stage.getWindowWidth() / stage.getZoomRatio() / 2;
                centerY = stage.getWindowHeight() / stage.getZoomRatio() / 2;
            }
            
            if(zoomOutEnabled == true && 
              (   mevent.getX() > zoomOut.getX() && mevent.getX() < zoomOut.getX() + zoomOut.getWidth()
               && mevent.getY() > zoomOut.getY() && mevent.getY() < zoomOut.getY() + zoomOut.getHeight() ) ){
                zoomRatio -= 0.1;
                stage.setZoomRatio(zoomRatio);
                print(stage.getZoomRatio());
                centerX = stage.getWindowWidth() / stage.getZoomRatio() / 2;
                centerY = stage.getWindowHeight() / stage.getZoomRatio() / 2;
            }
        } else if (mevent.getAction() == MOTION_EVENT_ACTION_UP) {
        	
        }
        //print(mevent.getAction());
    }
    function onKeyEvent(kevent) {
	  if (kevent.getAction() == KEY_EVENT_ACTION_DOWN) {
	    if (kevent.getKeyCode() == KEYCODE_BACK) {
	      print("Back button is pressed!");
	    }
	  }
	  return true;
	}
    
    /*
     * Called when the physics objects are collided.
     */
    function onContact(state, fixtureA, fixtureB, 
            position, normal, normalImpulse, tangentImpulse) {
        // state is contact point state aka b2PointState.
        // see http://programanddesign.com/box2d/b2Collision_8h.html for details
        if (state == PHYSICS_STATE_ADD) {
            // get the event coordinate
           	//local x = position.x * world.getScale();
            //local y = position.y * world.getScale();
            
            //print("PHYSICS_STATE_ADD");
            /*print(
                format("PHYSICS_STATE_ADD normalImpulse=%4.2f, tangentImpulse=%4.2f, x=%4.2f, y=%4.2f",
                normalImpulse, tangentImpulse, x, y));*/
        } else if (state == PHYSICS_STATE_PERSIST) {
        	//print("PHYSICS_STATE_PERSIST");
        } else if (state == PHYSICS_STATE_REMOVE) {
        	//print("PHYSICS_STATE_REMOVE");
        }
    }

    /*
     * Called when the physics objects are collided.
     */
    function onImpact(fixtureA, fixtureB,
            position, normal, normalImpulse, tangentImpulse) {
        bear.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
            	
        // get the event coordinate
        local x = position.x * world.getScale();
        local y = position.y * world.getScale();
	}
}