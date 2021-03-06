fps 						<- 120.0;

world 						<- emo.physics.World(emo.Vec2(0, 30), true);

zoomRatio 					<- 1.0;
zoomRate 					<- 0.01;

Camera_X 					<- 0;
Camera_Y 					<- 0;

Camera_Trace				<- null;

Stage_Visible_Width			<- 0;
Stage_Visible_Height		<- 0;

OBJECT_LAYER_NUM			<- 0;
INTERACT_LAYER_NUM			<- 0;
EVENT_LAYER_NUM				<- 0;

ui					<- UI();

sensorDetector 		<- SensorDetector();
gestureDetector 	<- GestureDetector();

recyclerobot		<- RecycleRobot();

layermanager		<- LayerManager();

bear				<- Bear();

emo.Audio.createEngine(3);

class Director {
	Level_Start_Time 	= 0;
	Level_Pause_Time	= 0;
	Total_Pause_Time    = 0;
	
	game_state = GAME_STATE.NOTHING;
	
	startpoint = null;
	endpoint = null;
	
	//audio = null;
	BGM = null;
	
	function getLevelTime() {
		return Level_Start_Time + Total_Pause_Time;
	}
	function setStartPoint(_coord) {
		startpoint = _coord;
	}
	function getStartPoint() {
		return startpoint;
	}
	function setEndPoint(_coord) {
		endpoint = _coord;
	}
	function getEndPoint() {
		return endpoint;
	}
	function setCameraTrace(sprite) {
		Camera_Trace = sprite;
	}
	function getCameraTrace() {
		return Camera_Trace;
	}
	function setGameState(state) {
		game_state = state;
	}
	function getGameState() {
		return game_state;
	}
	function SuccessGame() {
		this.setGameState(GAME_STATE.SUCCESS);
		
		stage.setZoomRatio(2);
		
		BGM.stop();
		
		bear.pauseAt(8);
		
		if(Debug) event.disableOnFpsCallback(1000); 
        
        emo.Event.disableOnDrawCallback();
        
        sensorDetector.disableSensors();
        
        ui.showSuccess();
	}
	function FailGame() {
		this.setGameState(GAME_STATE.FAILED);
		
		BGM.stop();
		
		bear.pause();
		
		if(Debug) event.disableOnFpsCallback(1000); 
        
        emo.Event.disableOnDrawCallback();
        
        sensorDetector.disableSensors();
        
        ui.showFail();
	}
	function PauseGame() {
		this.setGameState(GAME_STATE.PAUSING);
		
		Level_Pause_Time = runtime.uptime();
		//BGM.pause();
		
		bear.pause();
		
		if(Debug) event.disableOnFpsCallback(1000); 
        
        emo.Event.disableOnDrawCallback();
        
        sensorDetector.disableSensors();
	}
	function ResumeGame() {
		bear.setMotionStatus(BEAR_MOTION_STATUS.IDLE);
		
		Total_Pause_Time += runtime.uptime() - Level_Pause_Time;
		Level_Pause_Time = 0;
		//BGM.play();
		
		if(Debug) event.enableOnFpsCallback(1000);
        
        // set OnDrawCallback interval (millisecond)
        emo.Event.enableOnDrawCallback(1000.0 / fps);
        
        sensorDetector.enableSensors();
        
        this.setGameState(GAME_STATE.PLAYING);
	}
	function onLoad() {
		print("Director::onLoad()");
		
		stage.setContentScale(stage.getWindowHeight() / DESIGNED_RESOLUTION_HEIGHT);
		
		zoomRatio = stage.getWindowHeight() / DESIGNED_RESOLUTION_HEIGHT;
		stage.setZoomRatio(zoomRatio);
		
		ui.load();
        
        layermanager.load();
        
        if(Debug) event.enableOnFpsCallback(1000); 
        
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
        
		BGM = emo.Audio.createChannel(0);
        BGM.load("Chapter I-2.mp3");
		BGM.setLoop(true);
		BGM.play();
		
        this.onGainedFocus();
	}
	function onDrawFrame(dt) {
		// world step interval(second)
        world.step(dt / 1000.0, 10, 10);
		
		ui.onUpTime();
		
		layermanager.onUpTime();
		recyclerobot.onUpTime();
		
		if(Camera_Trace != null) CameraMoveByStage(Camera_Trace);
	}
	function onFps(fps) {
		ui.onFps(fps);
		//print("Director::onFps(fps), FPS: " + fps);
	}
	function onLowMemory() {
		runtime.error("Director::onLowMemory()");
	}
	function onGainedFocus() {
		print("Director::onGainedFocus()");
		
		BGM.play();
		
		sensorDetector.enableSensors();
		
		if(Level_Start_Time == 0) Level_Start_Time = runtime.uptime();
		director.setGameState(GAME_STATE.PLAYING);
		
		ui.onGainedFocus();
	}
	function onLostFocus() {
		print("Director::onLostFocus()");
		
		BGM.pause();
		
		sensorDetector.disableSensors();
	}
	function onDispose() {
		print("Director::onDispose()");
		
		BGM.close();
		
		emo.Event.disableOnDrawCallback();
		
		ui.remove();
		
		layermanager.remove();
		
		sensorDetector.remove();
        gestureDetector.remove();
        
        sensorDetector.disableSensors();
        
        director.setGameState(GAME_STATE.STOPING);
	}
	function onSensorEvent(sevent) {
		//print("Director::onSensorEvent(sevent)");
		if(game_state == GAME_STATE.PLAYING) sensorDetector.onSensorEvent(sevent);
	}
	function onMotionEvent(mevent) {
		//print("Director::onMotionEvent(mevent)");
		
		ui.onMotionEvent(mevent);
		if(game_state == GAME_STATE.PLAYING) layermanager.onMotionEvent(mevent);
		gestureDetector.onMotionEvent(mevent);
	}
	function onKeyEvent(kevent) {
		//print("Director::onKeyEvent(kevent)");
		
	}
	function onContact(state, fixtureA, fixtureB, 
            position, normal, normalImpulse, tangentImpulse) {
    	//print("Director::onContact()");
            
   	}
   	function onImpact(fixtureA, fixtureB,
            position, normal, normalImpulse, tangentImpulse) {
   		//print("Director::onImpact()");
   		layermanager.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
    
    }
    function CameraMoveByStage(sprite) {
    	local centerX = stage.getWindowWidth() / stage.getZoomRatio() / 2;
        local centerY = stage.getWindowHeight() / stage.getZoomRatio() / 2;
    	
    	local BIAS_X = sprite.getCenterX() - centerX;
        local BIAS_Y = sprite.getCenterY() - centerY;
        
        local stageZoomWidth = stage.getWindowWidth() / stage.getZoomRatio();
        local stageZoomHeight = stage.getWindowHeight() / stage.getZoomRatio();
        
        if(stageZoomWidth >= Stage_Visible_Width) BIAS_X = -(stageZoomWidth - Stage_Visible_Width) / 2;
        else if(BIAS_X <= 0) BIAS_X = 0;
        else if(BIAS_X + stageZoomWidth >= Stage_Visible_Width) BIAS_X = Stage_Visible_Width - stageZoomWidth;
        
        if(stageZoomHeight >= Stage_Visible_Height) BIAS_Y = -(stageZoomHeight - Stage_Visible_Height) / 2;
        else if(BIAS_Y <= 0) BIAS_Y = 0;
        else if(BIAS_Y + stageZoomHeight >= Stage_Visible_Height) BIAS_Y = Stage_Visible_Height - stageZoomHeight;
        
        stage.moveCamera(BIAS_X, BIAS_Y);
        Camera_X = BIAS_X;
        Camera_Y = BIAS_Y;
    }
    function LoadCurrentLevel() {
    	LoadScript(Current_Level_Id);
    }
    function LoadNextLevel() {
    	this.onDispose();
    	Current_Level_Id++;
    	LoadScript(Current_Level_Id);
    }
    function LoadPreviousLevel() {
    	this.onDispose();
    	Current_Level_Id--;
    	LoadScript(Current_Level_Id);
    }
}

director 			<- Director();