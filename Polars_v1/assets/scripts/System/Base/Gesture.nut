GESTURE_TYPE_SWIPE					<- 0;
GESTURE_TYPE_SWIPE_KEY 				<- "Swipe";
GESTURE_SWIPE_SPEED_THRESHOLD 		<- 1;
GESTURE_MOVE_X_THRESHOLD			<- 20;
GESTURE_MOVE_Y_THRESHOLD			<- 20;
GESTURE_MOVE_TIME_THRESHOLD			<- 10;
GESTURE_EVENT_MIN_PERIOD			<- 100;

class GestureDetector {
	
	ListenerTable = {};
	constructor() {
		ListenerTable.clear();
	}
	function onMotionEvent(mevent) {
		if(ListenerTable.rawin(GESTURE_TYPE_SWIPE_KEY))
			for(local i=0; i<ListenerTable.Swipe.len(); i++)
				ListenerTable.Swipe[i].onCall(mevent);
	}
	function addSwipeListener(listener) {
		if(ListenerTable.rawin(GESTURE_TYPE_SWIPE_KEY)) ListenerTable.Swipe.append(listener);
		else ListenerTable.rawset(GESTURE_TYPE_SWIPE_KEY, [listener]);
	}
	function removeSwipeListener(listener) {
		if(ListenerTable.rawin(GESTURE_TYPE_SWIPE_KEY))
			ListenerTable.Swipe.remove(ListenerTable.Swipe.find(listener));
	}
	function removeAllListener() {
		if(ListenerTable.rawin(GESTURE_TYPE_SWIPE_KEY)) {
			for(local i=0; i<ListenerTable.Swipe.len(); i++)
				ListenerTable.Swipe[i] = ListenerTable.Swipe[i].remove;
			ListenerTable.Swipe.clear();
			ListenerTable.rawdelete(GESTURE_TYPE_SWIPE_KEY);
		}
	}
	function remove() {
		this.removeAllListener();
		return null;
	}
}

class GestureListener {
	enable = false;
	gestureType = null;
	
	touch_id = null;
	constructor(_type, _bool = true) {
		enable = _bool;
		gestureType = _type;
	}
	function setEnable(_bool) {
		enable = _bool;
	}
	function getEnable(_bool) {
		return enable;
	}
	function onCall(mevent) {
		local id = mevent.getPointerId();
        local action = mevent.getAction();
		
		if(gestureType == null) print("Must implement TypeListener!");
		else if((touch_id == null || id == touch_id) && enable) {
			this.onEvent(mevent);
			//print("mevent.getAction()");
			switch(action) {
				case MOTION_EVENT_ACTION_DOWN:
					if(touch_id == null) {
						touch_id = id;
						this.ACTION_DOWN(mevent);
					}
				break;
				case MOTION_EVENT_ACTION_UP:
					if(touch_id != null) {
						touch_id = null;
						this.ACTION_UP(mevent);
					}
				break;
				case MOTION_EVENT_ACTION_MOVE:
					if(touch_id != null) this.ACTION_MOVE(mevent);
				break;
				case MOTION_EVENT_ACTION_CANCEL:
					if(touch_id != null) this.ACTION_CANCEL(mevent);
				break;
				case MOTION_EVENT_ACTION_OUTSIDE:
					if(touch_id != null) this.ACTION_OUTSIDE(mevent);
				break;
				case MOTION_EVENT_ACTION_POINTER_DOWN:
					if(touch_id == null) {
						touch_id = id;
						this.ACTION_POINTER_DOWN(mevent);
					}
				break;
				case MOTION_EVENT_ACTION_POINTER_UP:
					if(touch_id != null) {
						touch_id = null;
						this.ACTION_POINTER_UP(mevent);
					}
				break;
			}
		}
	}
	function onEvent(mevent) {}
	function ACTION_DOWN(mevent) {}
	function ACTION_UP(mevent) {}
	function ACTION_MOVE(mevent) {}
	function ACTION_CANCEL(mevent) {}
	function ACTION_OUTSIDE(mevent) {}
	function ACTION_POINTER_DOWN(mevent) {}
	function ACTION_POINTER_UP(mevent) {}
	function remove() {
		return null;
	}
}

class SwipeListener extends GestureListener {
	DOWN_TIME = 0;
	MOVE_TIME = 0;
	UP_TIME = 0;
	DOWN_X = 0;
	DOWN_Y = 0;
	MOVE_X = 0;
	MOVE_Y = 0;
	UP_X = 0;
	UP_Y = 0;
	SPEED_X = 0;
	SPEED_Y = 0;
	EVENT_TIME = 0;
	
	swipe_speed_threshold = null;
	
	constructor(_bool = true, _swipe_speed_threshold = GESTURE_SWIPE_SPEED_THRESHOLD) {
		base.constructor(GESTURE_TYPE_SWIPE, _bool);
		swipe_speed_threshold = _swipe_speed_threshold;
	}
	function ACTION_DOWN(mevent) {
		//print("MOTION_EVENT_ACTION_DOWN");
		DOWN_X = mevent.getX();
        DOWN_Y = mevent.getY();
        DOWN_TIME = runtime.uptime();
	}
	function ACTION_MOVE(mevent) {
		local MOVE_DIFF_X = mevent.getX() - MOVE_X;
		local MOVE_DIFF_Y = mevent.getY() - MOVE_Y;
		MOVE_X = mevent.getX();
        MOVE_Y = mevent.getY();
        local MOVE_DIFF_TIME = runtime.uptime() - MOVE_TIME;
        MOVE_TIME = runtime.uptime();
        
        if(fabs(MOVE_DIFF_X) > GESTURE_MOVE_X_THRESHOLD && MOVE_DIFF_TIME > GESTURE_MOVE_TIME_THRESHOLD)
        	SPEED_X = (MOVE_DIFF_X)/(MOVE_DIFF_TIME);
        else SPEED_X = 0;
        if(fabs(MOVE_DIFF_Y) > GESTURE_MOVE_Y_THRESHOLD && MOVE_DIFF_TIME > GESTURE_MOVE_TIME_THRESHOLD)
        	SPEED_Y = (MOVE_DIFF_Y)/(MOVE_DIFF_TIME);
        else SPEED_Y = 0;
	    
	    local speed = emo.Vec2(SPEED_X, SPEED_Y);
	    local EVENT_DIFF_TIME = runtime.uptime() - EVENT_TIME;
	    //print("SPEED_X: " + SPEED_X + " SPEED_Y: " + SPEED_Y + " EVENT_TIME: " + EVENT_TIME);
	    if(fabs(SPEED_X) > swipe_speed_threshold && EVENT_DIFF_TIME > GESTURE_EVENT_MIN_PERIOD)
	    	if(SPEED_X < 0) {
	    		onSwipeLeft(speed);
	    		EVENT_TIME = runtime.uptime();
	    	} else if(SPEED_X > 0) {
	    		onSwipeRight(speed);
	    		EVENT_TIME = runtime.uptime();
	    	}
	    if(fabs(SPEED_Y) > swipe_speed_threshold && EVENT_DIFF_TIME > GESTURE_EVENT_MIN_PERIOD)
	    	if(SPEED_Y < 0) {
	    		onSwipeUp(speed);
	    		EVENT_TIME = runtime.uptime();
	    	} else if(SPEED_Y > 0) {
	    		onSwipeDown(speed);
	    		EVENT_TIME = runtime.uptime();
	    	}
	}
	function ACTION_UP(mevent) {
		UP_X = mevent.getX();
	    UP_Y = mevent.getY();
	    UP_TIME = runtime.uptime();
	        	
	    /*SPEED_X = (UP_X - DOWN_X)/(UP_TIME-DOWN_TIME);
	    SPEED_Y = (UP_Y - DOWN_Y)/(UP_TIME-DOWN_TIME);
	        	
	    local speed = emo.Vec2(SPEED_X, SPEED_Y);
	    if(fabs(SPEED_X) > swipe_speed_threshold)
	    	if(SPEED_X < 0) onSwipeRight(speed);
	    	else if(SPEED_X > 0) onSwipeLeft(speed);
	    if(fabs(SPEED_Y) > swipe_speed_threshold)
	    	if(SPEED_Y < 0) onSwipeUp(speed);
	    	else if(SPEED_Y > 0) onSwipeDown(speed);*/
	    	
	    //print("MOTION_EVENT_ACTION_UP");
	    //print("SPEED_X: " + SPEED_X + " SPEED_Y: " + SPEED_Y);
	        	
	    DOWN_TIME = 0;
	    UP_TIME = 0;
	    MOVE_TIME = 0;
	    DOWN_X = 0;
	    DOWN_Y = 0;
	    MOVE_X = 0;
	    MOVE_Y = 0;
	    UP_X = 0;
	    UP_Y = 0;
	    SPEED_X = 0;
	    SPEED_Y = 0;
	}
	function onSwipeUp(speed) {print("onSwipeUp");}
	function onSwipeDown(speed) {print("onSwipeDown");}
	function onSwipeLeft(speed) {print("onSwipeLeft");}
	function onSwipeRight(speed) {print("onSwipeRight");}
}