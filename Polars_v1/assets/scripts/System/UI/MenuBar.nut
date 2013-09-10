class BACK extends SpriteSheetButton {
	constructor(rawname, width, height, border, margin) {
		//print("BACK::constructor");
		base.constructor(rawname, width, height, border, margin);
	}
	function onSelect(mevent) {
		print("BACK::onSelect()");
		//emo.Audio.vibrate();
		runtime.finish();
	}
	function onPress(mevent) {
		object.setFrame(1);
	}
	function onRelease(mevent) {
		object.setFrame(0);
	}
}

class HOME extends SpriteSheetButton {
	constructor(rawname, width, height, border, margin) {
		//print("HOME::constructor");
		base.constructor(rawname, width, height, border, margin);
	}
	function onSelect(mevent) {
		print("HOME::onSelect()");
		//emo.Audio.vibrate();
        local intent = emo.Android.Intent("com.meigic.polars.BackToMain");
        emo.Android.transit(intent);
	}
	function onPress(mevent) {
		object.setFrame(1);
	}
	function onRelease(mevent) {
		object.setFrame(0);
	}
}

class RESTART extends SpriteSheetButton {
	constructor(rawname, width, height, border, margin) {
		//print("HOME::constructor");
		base.constructor(rawname, width, height, border, margin);
	}
	function onSelect(mevent) {
		//print("HOME::onSelect()");
		//emo.Audio.vibrate();
        //runtime.finish();
        //director.onDispose();
        
        local intent = emo.Android.Intent("com.meigic.polars.Replay");
        emo.Android.transit(intent);

		//runtime.finish();
        //director.onDispose();
	}
	function onPress(mevent) {
		object.setFrame(1);
	}
	function onRelease(mevent) {
		object.setFrame(0);
	}
}

class LEVELS extends SpriteSheetButton {
	constructor(rawname, width, height, border, margin) {
		//print("HOME::constructor");
		base.constructor(rawname, width, height, border, margin);
	}
	function onSelect(mevent) {
		//print("HOME::onSelect()");
		//emo.Audio.vibrate();
        runtime.finish();
	}
	function onPress(mevent) {
		object.setFrame(1);
	}
	function onRelease(mevent) {
		object.setFrame(0);
	}
}

class MenuBar {
	isGui = false;
	
	z = 0;
	
	//back = BACK("Back_100x100.png", 100, 100, 0, 0);
	//home = HOME("Home_100x100.png", 100, 100, 0, 0);
	//restart = RESTART("Restart_100x100.png", 100, 100, 0, 0);
	levels = LEVELS("Levels_100x100.png", 100, 100, 0, 0);
	function load() {
		/*if(isGui) back.setAsGui();
		back.addText("BACK", 1);
		back.setTextColor(0, 0, 0);
		back.move(0, stage.getWindowHeight() - back.getHeight());
		back.alpha(0.5);
		back.setZ(z);
		back.load();
		
		if(isGui) home.setAsGui();
		home.addText("HOME", 1);
		home.setTextColor(0, 0, 0);
		home.move(back.getX() + back.getWidth(), stage.getWindowHeight() - home.getHeight());
		home.alpha(0.5);
		home.setZ(z);
		home.load();*/
		
		if(isGui) levels.setAsGui();
		levels.addText("LEVEL", 1);
		levels.setTextColor(0, 0, 0);
		levels.move(0, stage.getWindowHeight() - levels.getHeight());
		levels.alpha(0.5);
		levels.setZ(z);
		levels.load();
		
		/*if(isGui) restart.setAsGui();
		restart.addText("REPLAY", 1);
		restart.setTextColor(0, 0, 0);
		restart.move(levels.getX() + levels.getWidth(), stage.getWindowHeight() - levels.getHeight());
		restart.alpha(0.5);
		restart.setZ(z);
		restart.load();*/
	}
	function remove() {
		//back.remove();
		//home.remove();
		
		levels.remove();
		//restart.remove();
	}
	function setZ(_z) {
		z = _z;
		
		//back.setZ(z);
		//home.setZ(z);
		levels.setZ(z);
		//restart.setZ(z);
	}
	function alpha(_a) {
		levels.alpha(_a);
		//restart.alpha(_a);
	}
	function setAsGui() {
		isGui = true;
		
		//back.setAsGui();
		//home.setAsGui();
		levels.setAsGui();
		//restart.setAsGui();
	}
	function onGainedFocus() {
	}
	function onLostFocus() {
	}
	function onUpTime() {
		//home.onUpTime();
		//back.onUpTime();
		
		levels.onUpTime();
		//restart.onUpTime();
	}
	function onMotionEvent(mevent) {
		//back.onMotionEvent(mevent);
		//home.onMotionEvent(mevent);
		
		levels.onMotionEvent(mevent);
		//restart.onMotionEvent(mevent);
	} 
}