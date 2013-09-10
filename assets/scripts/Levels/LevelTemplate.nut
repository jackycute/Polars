class LevelTemplate {
	
	function onLoad() {
		
		director.onLoad();
	}
	function onDrawFrame(dt) {
		
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
            	
    	director.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
    }
}

Current_Level_Function = LevelTemplate();