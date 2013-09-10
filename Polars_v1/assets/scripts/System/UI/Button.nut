class LONGPRESS_TIMER extends Timer {
	master = null;
	mevent = null;
    constructor(_total_interval, _tick_interval) {
    	base.constructor(_total_interval, _tick_interval);
    }
    function setMaster(_master) {
    	master = _master;
    }
    function setMevent(_mevent) {
    	mevent = _mevent;
    }
    function onStart() {
	}
    function onTick(ticks) {
	}
	function onFinish() {
		//print("onFinish");
		local mX = 0;
        local mY = 0;
        if(master.isGui) {
        	mX = mevent.getX();
        	mY = mevent.getY();
        } else {
        	mX = mevent.getX() + Camera_X;
        	mY = mevent.getY() + Camera_Y;
        }
		
		if((master.getObject() != null && master.getObject().contains(mX, mY))
						|| (master.getText() != null && master.getText().contains(mevent.getX(), mevent.getY())))
		if(master.getState() == STATE.PRESSED) master.onLongPress(mevent);
	}
}

class Button {
	object = null;
	text = null;
	
	x = 0;
	y = 0;
	
	loaded = false;
	isGui = false;
	isVisible = false;
	
	button_text = null;
	text_align = null;
	
	state = null;
	down_time = 0;
	longpress_timer = null;
	
	touch_id = null;
	constructor(_object) {
		//print("BUTTON::constructor");
		object = _object;
		
		text_align = [HORIZONTAL_ALIGH.CENTER, VERTICAL_ALIGH.CENTER];
		
		state = STATE.NORMAL;
		
		x = 0;
		y = 0;
		loaded = false;
		isGui = false;
		isVisible = false;
	}
	function getObject() {
		return object;
	}
	function getPhysicsInfo() {
		return object.getPhysicsInfo();
	}
	function isLoaded() {
		return loaded;
	}
	function collidesWith(sprite) {
		return object.collidesWith(sprite);
	}
	function changeObject(_object) {
		if(object != null) object.remove();
		object = _object;
	}
	function getId() {
		if(object != null) return object.getId();
		else if(text != null) return text.getId();
		else return null;
	}
	function addText(_string, _size = 1) {
		if(_size == 1)
			text = TextSprite("default_font_16x24.png",
	        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
	        16, 24, 0, 0);
        else
        	text = TextSprite("default_font_32x48.png",
	        " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
	        32, 48, 0, 0);
        //text.scale(_size/60, _size/60);
        //text = emo.FontSprite("custom", _size, "GOTHICB"); 
        this.setText(_string);
        if(loaded) text.load();
        if(isGui) text.setAsGui();
        text.color(object.red(), object.green(), object.blue(), object.alpha());
        text.setZ(object.getZ() + 1);
        this.move(x, y);
	}
	function getText() {
		return text;
	}
	function removeText() {
		if(text != null) {
			text.remove();
			text = null;
		}
	}
	function getTextWidth() {
		if(text != null) return text.getWidth();
		else return 0;
	}
	function getTextHeight() {
		if(text != null) return text.getHeight();
		else return 0;
	}
	function setText(_string) {
		button_text = _string;
        if(text != null) {
        	text.setText(button_text);
        	//text.setParam(button_text);
        	//text.reload();
        }
        
        this.move(this.getX(), this.getY());
	}
	function setTextScale(_text_scale) {
		if(text != null) text.setScale(_text_scale, _text_scale);
	}
	function setTextAlign(_text_align) {
		if(text != null) {
			text_align[0] = _text_align[0];
			text_align[1] = _text_align[1];
		}
	}
	function setTextColor(_r, _g, _b, _a = null) {
		if(text != null) text.color(_r, _g, _b, _a);
	}
	function showText() {
		if(text != null) text.show();
	}
	function hideText() {
		if(text != null) text.hide();
	}
	function load() {
		if(object != null) object.load();
		if(text != null) text.load();
		loaded = true;
		isVisible = true;
		
		this.move(x, y);
	}
	function remove() {
		if(object != null) {
			object.remove();
			object = null;
		}
		if(text != null) {
			text.remove();
			text = null;
		}
	}
	function show() {
		if(object != null) object.show();
		if(text != null) text.show();
		
		isVisible = true;
	}
	function hide() {
		if(object != null) object.hide();
		if(text != null) text.hide();
		
		isVisible = false;
	}
	function alpha(_a = null) {
		if(_a == null) {
			if(object != null) return object.alpha();
			else if(text != null) return text.alpha();
		} else {
			if(object != null) object.alpha(_a);
			if(text != null) text.alpha(_a);
			
			if(_a > 0) isVisible = true;
			else if(_a == 0) isVisible = false;
		}
	}
	function move(_x, _y) {
		x = _x;
		y = _y;
		if(object != null) object.move(x, y);
		if(object != null && text != null) {
			local text_x = 0;
			local text_y = 0;
			switch(text_align[0]) {
				case HORIZONTAL_ALIGH.LEFT:
					text_x = x;
					//print("CHECK1");
				break;
				case HORIZONTAL_ALIGH.RIGHT:
					text_x = x + object.getWidth() - text.getWidth();
				break;
				case HORIZONTAL_ALIGH.CENTER:
					text_x = x + (object.getWidth() - text.getWidth())/2;
				break;
			}
			switch(text_align[1]) {
				case VERTICAL_ALIGH.TOP:
					text_y = y;
					//print("CHECK2");
				break;
				case VERTICAL_ALIGH.BOTTOM:
					text_y = y + object.getHeight() - text.getHeight();
				break;
				case VERTICAL_ALIGH.CENTER:
					text_y = y + (object.getHeight() - text.getHeight())/2;
				break;
			}
			text.move(text_x, text_y);
			//print(format("text_x: %d, text_y: %d", text_x, text_y));
		}
		//print(format("X: %d, Y: %d", x, y));
	}
	function getWidth() {
		if(object != null) return object.getWidth();
		else return 0;
	}
	function getHeight() {
		if(object != null) return object.getHeight();
		else return 0;
	}
	function getX() {
		return x;
	}
	function getY() {
		return y;
	}
	function setZ(_z) {
		if(object != null) object.setZ(_z);
		if(text != null) text.setZ(_z + 1);
	}
	function getZ() {
		if(object != null) return object.getZ();
		else return 0;
	}
	function scale(_scale) {
		if(object != null) object.scale(_scale, _scale);
	}
	function color(_r, _g, _b, _a = null) {
		if(object != null) object.color(_r, _g, _b, _a);
	}
	function setAsGui() {
		if(object != null) object.setAsGui();
		if(text != null) text.setAsGui();
		isGui = true;
	}
	function getState() {
		return state;
	}
	function applySettings(sprite) {
		sprite.setZ(this.getZ()+1);
		sprite.move(this.getX(), this.getY());
		if(isGui) sprite.setAsGui();
		if(loaded) sprite.load();
	}
	function onMotionEvent(mevent) {
		local id = mevent.getPointerId();
        local action = mevent.getAction();
        local mX = 0;
        local mY = 0;
        if(isGui) {
        	mX = mevent.getX();
        	mY = mevent.getY();
        } else {
        	mX = mevent.getX() + Camera_X;
        	mY = mevent.getY() + Camera_Y;
        }
		//print("mevent.getAction(): " + mevent.getAction());
		if(isVisible && (touch_id == null || id == touch_id)) {
		switch(mevent.getAction()) {
			case MOTION_EVENT_ACTION_DOWN:
				if(touch_id == null)
				if((object != null && object.contains(mX, mY)) 
					|| (text != null && text.contains(mX, mY))) {
					touch_id = id;
					if(down_time == 0) {
						down_time = runtime.uptime();
						longpress_timer = LONGPRESS_TIMER(1000, 1000);
						longpress_timer.setMevent(mevent);
						longpress_timer.setMaster(this);
						longpress_timer.start();
					}
					state = STATE.PRESSED;
					this.onPress(mevent);
				} else {
					//state = STATE.NORMAL;
					down_time = 0;
					//this.onRelease();
				}
			break;
			case MOTION_EVENT_ACTION_UP:
				if(id == touch_id)
				if((object != null && object.contains(mX, mY))
					|| (text != null && text.contains(mX, mY))) {
						if(state == STATE.PRESSED) {
							this.onSelect(mevent);
							state = STATE.NORMAL;
							this.onRelease(mevent);
						}
						else if(state == STATE.LONG_PRESSED) {
							state = STATE.NORMAL;
							this.onRelease(mevent);
						}
						
						touch_id = null;
					if(longpress_timer != null) longpress_timer = longpress_timer.remove();
					down_time = 0;
				} else {
					this.onRelease(mevent);
					touch_id = null;
					if(longpress_timer != null) longpress_timer = longpress_timer.remove();
					down_time = 0;
				}
			break;
			case MOTION_EVENT_ACTION_MOVE:
				if(id == touch_id)
				if((object != null && object.contains(mX, mY))
						|| (text != null && text.contains(mX, mY))) {
					if(state == STATE.PRESSED || state == STATE.LONG_PRESSED) this.onMove(mevent);
				}/* else {
					this.onRelease(mevent);
					touch_id = null;
				}*/
			break;
		}
		}
	}
	function onUpTime() {
		if(longpress_timer != null) longpress_timer.onUpTime();
	}
	function onPress(mevent) {
		print("Button::onPress()");
	}
	function onRelease(mevent) {
		print("Button::onRelease()");
	}
	function onLongPress(mevent) {
		print("Button::onLongPress()");
	}
	function onSelect(mevent) {
		print("Button::onSelect()");
	}
	function onMove(mevent) {
		print("Button::onMove()");
	}
}

class SpriteButton extends Button {
	constructor(rawname) {
		local object = emo.Sprite(rawname);
		base.constructor(object);
	}
}

class SpriteSheetButton extends Button {
	constructor(rawname, width, height, border, margin) {
		local object = emo.SpriteSheet(rawname, width, height, border, margin);
		
		//print("SpriteSheetButton::constructor: " + _string);
		base.constructor(object);
	}
}

class RectangleButton extends Button {
	constructor(size_x, size_y) {
		local object = emo.Rectangle();
		object.setSize(size_x, size_y);
		base.constructor(object);
	}
}