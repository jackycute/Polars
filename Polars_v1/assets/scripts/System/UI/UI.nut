UI_Z		<- 100;

class DOLPHIN extends SpriteButton {
	constructor(rawname) {
		base.constructor(rawname);
		this.show();
	}
	function onSelect(mevent) {
		print("DOLPHIN::onSelect()");
		if(ui.getItemMenu().isVisible()) {
			ui.getItemMenu().hide();
			director.ResumeGame();
		} else {
			ui.getItemMenu().show();
			ui.getItemMenu().alpha(0.5);
			local tempArray = ui.getItemMenu().getObjectArray();
			for(local i = 0; i < tempArray.len(); i++)
				tempArray[i].alpha(1);
			director.PauseGame();
		}
	}
	function onPress(mevent) {
		print("DOLPHIN::onPress()");
		this.alpha(0.5);
	}
	function onRelease(mevent) {
		print("DOLPHIN::onRelease()");
		this.alpha(1);
	}
	function onLongPress(mevent) {
		print("DOLPHIN::onLongPress()");
	}
	function onMove(mevent) {
		print("DOLPHIN::onMove()");
	}
}

class UI {
	levelname = TextSprite("default_font_32x48.png",
        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        32, 48, 0, 0);
    
    text_fps = TextSprite("default_font_32x48.png",
        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        32, 48, 0, 0);
        
    message = TextSprite("default_font_32x48.png",
        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        32, 48, 0, 0);
        
    timer = TextSprite("default_font_32x48.png",
        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        32, 48, 0, 0);
        
    dolphin = DOLPHIN("Dolphin.png");
	
	menubar = MenuBar();
	itemmenu = ItemMenu(425, 425, 5, 5);
	mask = emo.Rectangle();
	
	function getItemMenu() {
		return itemmenu;
	}
	function getDolphin() {
		return dolphin;
	}
	function load() {
		levelname.setText(LEVEL_INFO[Current_Level_Id].name);
        levelname.setAsGui();
        levelname.color(0, 0, 0);
        //levelname.addBackFrame(5);
        //levelname.setBackFrame(1, 1, 1);
        levelname.move((stage.getWindowWidth()-levelname.getWidth())/2, 0);
        levelname.setZ(UI_Z);
        levelname.load();
        levelname.hide();
        
        timer.setAsGui();
        timer.color(0, 0, 1, 0.5);
        timer.setZ(UI_Z);
        timer.load();
        timer.hide();
        
        text_fps.setAsGui();
        text_fps.color(1, 1, 0, 0.5);
        text_fps.move(stage.getWindowWidth() - text_fps.getWidth(), stage.getWindowHeight() - text_fps.getHeight());
        text_fps.setZ(UI_Z);
        text_fps.load();
        text_fps.show();
        
        message.setAsGui();
        message.setZ(UI_Z);
        message.load();
        message.hide();
        
        mask.setAsGui();
        mask.move(0, 0);
		mask.setZ(UI_Z - 1);
		mask.load();
		mask.hide();
        
        dolphin.setAsGui();
        dolphin.move(0, (stage.getWindowHeight() - dolphin.getHeight())/2);
        dolphin.setZ(UI_Z);
        dolphin.load();
        
        menubar.setAsGui();
        menubar.setZ(UI_Z);
        menubar.load();
        
        itemmenu.setAsGui();
        itemmenu.setZ(UI_Z);
        itemmenu.load();
        itemmenu.hide();
	}
	function remove() {
		levelname.remove();
		text_fps.remove();
		message.remove();
		dolphin.remove();
		mask.remove();
		timer.remove();
		
		menubar.remove();
        itemmenu.remove();
	}
	function showFail() {
		dolphin.hide();
		
		message.setText("Mission Failed");
		message.color(1, 0, 0);
		message.move((stage.getWindowWidth() - message.getWidth())/2, (stage.getWindowHeight() - message.getHeight())/2);
		message.show();
		
		mask.setSize(stage.getWindowWidth()*2, stage.getWindowHeight()*2);
		mask.color(0, 0, 0, 0.5);
		
		menubar.alpha(1);
	}
	function showSuccess() {
		dolphin.hide();
		
		message.setText("Mission Success!");
		message.color(1, 0, 0);
		message.move((stage.getWindowWidth() - message.getWidth())/2, 10);
		message.show();
		
		local elpased = (runtime.uptime() - director.getLevelTime())/1000;
		timer.setText(format("You Spend: %02d second!", elpased));
		timer.move((stage.getWindowWidth() - timer.getWidth())/2, message.getY() + message.getHeight() + 10);
		timer.show();
		
		menubar.alpha(1);
	}
	function onGainedFocus() {
		local sequence = emo.SequenceModifier();
		local fadeIn = emo.AlphaModifier(0, 1, 2000, emo.easing.Linear);
		local fadeOut = emo.AlphaModifier(1, 0, 2000, emo.easing.Linear);
		sequence.addModifier(fadeIn);
		sequence.addModifier(fadeOut);
		//levelname.getBackFrame().addModifier(sequence);
		levelname.addModifier(sequence);
		
		menubar.onGainedFocus();
        itemmenu.onGainedFocus();
	}
	function onLostFocus() {
		
		menubar.onLostFocus();
        itemmenu.onLostFocus();
	}
	function onFps(fps) {
		text_fps.setText(format("%2d", fps));
		text_fps.move(stage.getWindowWidth() - text_fps.getWidth(), stage.getWindowHeight() - text_fps.getHeight());
		//print(format("Director::onFps(fps), FPS: %f", fps));
	}
	function onUpTime() {
		if(director.getGameState() == GAME_STATE.PLAYING) {
			local elpased = (runtime.uptime() - director.getLevelTime())/1000;
			timer.setText(format("%02d", elpased));
			timer.move((stage.getWindowWidth() - timer.getWidth())/2, levelname.getY() + levelname.getHeight());
			timer.show();
		} else timer.hide();
		
		dolphin.onUpTime();
		menubar.onUpTime();
        itemmenu.onUpTime();
		
		//level_name_timer.onUpTime();
		/*if(text_starttime == 0) text_starttime = runtime.uptime();
		else text_elapsed = runtime.uptime() - text_starttime;
		if(text_alpha < 1 && !text_shown) {
			text_alpha_rate = 1*emo.easing.Linear(text_elapsed.tofloat(), text_duration.tofloat(), null);
			text_alpha += text_alpha_rate;
			if(text_alpha <= 1) text.alpha(text_alpha);
			//print("text_alpha_rate: " + text_alpha_rate);
		} else if(text_alpha > 0 || text_shown) {
			text_alpha_rate = 1*emo.easing.Linear(text_elapsed.tofloat(), text_duration.tofloat(), null);
			text_starttime = runtime.uptime();
			text_shown = true;
			text_alpha -= text_alpha_rate;
			if(text_alpha <= 1) text.alpha(text_alpha);
			//print("text_alpha_rate: " + text_alpha_rate);
		}*/
	}
	function onMotionEvent(mevent) {
		dolphin.onMotionEvent(mevent);
		menubar.onMotionEvent(mevent);
        itemmenu.onMotionEvent(mevent);
	}
}