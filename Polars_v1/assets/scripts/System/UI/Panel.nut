class Panel {
	panel_object = null;
	object_array = null;
	
	x = 0;
	y = 0;
	z = 0;
	
	r = 0;
	g = 0;
	b = 0;
	a = 0;
	
	isGui = false;
	isLoaded = false;
	
	column = 0;
	row = 0;
	
	border = 0;
	margin = 0;
	child_align = null;
	constructor(_panel_object, _border, _margin, _child_align) {
		panel_object = _panel_object;
		object_array = [];
		
		panel_object.setZ(z);
		panel_object.color(r, g, b, a);
		if(isGui) panel_object.setAsGui();
		
		border = _border;
		margin = _margin;
		if(_child_align == null) child_align = [HORIZONTAL_ALIGH.LEFT, VERTICAL_ALIGH.TOP];
		else child_align = _child_align;
		
		isLoaded = false;
	}
	function getObjectArray() {
		return object_array;
	}
	function isLoaded() {
		return isLoaded;
	}
	function load() {
		if(panel_object != null) panel_object.load();
		for(local i = 0; i < object_array.len(); i++)
			if(object_array[i] != null) object_array[i].load();
		updateChild();
		
		isLoaded = true;
	}
	function remove() {
		if(panel_object != null) panel_object.remove();
		if(object_array != null)
		for(local i = 0; i < object_array.len(); i++)
			if(object_array[i] != null) object_array[i].remove();
		object_array.clear();
	}
	function move(_x, _y) {
		local diff_x = x - _x;
		local diff_y = y - _y;
		
		x = _x;
		y = _y;
		
		if(panel_object != null) panel_object.move(x, y);
		if(object_array != null)
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].move(object_array[i].getX() + diff_x, object_array[i].getY() + diff_y);
		}
		
		updateChild();
	}
	function setZ(_z) {
		z = _z;
		if(panel_object != null) panel_object.setZ(z);
		if(object_array != null)
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].setZ(z+1);
		}
	}
	function getWidth() {
		if(panel_object != null) return panel_object.getWidth();
		else return 0;
	}
	function getHeight() {
		if(panel_object != null) return panel_object.getHeight();
		else return 0;
	}
	function getX() {
		return panel_object.getX();
	}
	function getY() {
		return panel_object.getY();
	}
	function alpha(_alpha = null) {
		if(_alpha == null) return panel_object.alpha();
		else {
			panel_object.alpha(_alpha);
			for(local i = 0; i < object_array.len(); i++)
			if(object_array[i] != null) object_array[i].alpha(_alpha);
		}
	}
	function isVisible() {
		if(a > 0) return true;
		else false;
	}
	function show() {
		a = 1;
		if(panel_object != null) panel_object.show();
		if(object_array != null)
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].show();
		}
	}
	function hide() {
		a = 0;
		if(panel_object != null) panel_object.hide();
		if(object_array != null)
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].hide();
		}
	}
	function color(_r, _g, _b, _a = null) {
		r = _r;
		g = _g;
		b = _b;
		if(_a != null) a = _a; 
		if(panel_object != null) panel_object.color(r, g, b, a);
	}
	function setAsGui() {
		isGui = true;
		
		if(panel_object != null) panel_object.setAsGui();
		if(object_array != null)
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].setAsGui();
		}
	}
	function updateChild() {
		for(local i = 0; i < object_array.len(); i++) {
			local temp_x = 0;
			local temp_y = 0;
			switch(child_align[0]) {
				case HORIZONTAL_ALIGH.LEFT:
					if(i == 0) temp_x = this.getX() + border;
					else if(object_array[i-1].getX() + object_array[i-1].getWidth() <= this.getWidth() + margin + object_array[i].getWidth()) {
						temp_x = object_array[i-1].getX() + object_array[i-1].getWidth() + margin;
					} else {
						temp_x = this.getX() + border;
						//print(object_array[i-1].getX() + object_array[i-1].getWidth() + margin + object_array[i].getWidth());
					}
				break;
				case HORIZONTAL_ALIGH.RIGHT:
				
				break;
				case HORIZONTAL_ALIGH.CENTER:
				
				break;
			}
			switch(child_align[1]) {
				case VERTICAL_ALIGH.TOP:
					if(i == 0) temp_y = this.getY() + border;
					else if(object_array[i-1].getX() + object_array[i-1].getWidth() <= this.getWidth() + margin + object_array[i].getWidth()) {
						/*local lastMaxHeight = 0;
						for(local j = i-1; j-1 > 0 && object_array[j].getY() == object_array[j-1].getY(); j++) {
							if(object_array[j].getHeight() > lastMaxHeight) lastMaxHeight = object_array[j].getHeight();
							if(object_array[j-1].getHeight() > lastMaxHeight) lastMaxHeight = object_array[j-1].getHeight();
						}*/
						temp_y = object_array[i-1].getY();
					} else {
						temp_y = object_array[i-1].getY() + object_array[i-1].getHeight() + margin;
					}
				break;
				case VERTICAL_ALIGH.BOTTOM:
				
				break;
				case VERTICAL_ALIGH.CENTER:
				
				break;
			}
			object_array[i].move(temp_x, temp_y);
		}
	}
	function addChild(_child) {
		if(isGui) _child.setAsGui();
		_child.alpha(panel_object.alpha());
		_child.setZ(z+1);
		if(isLoaded) _child.load();
		object_array.append(_child);
		
		updateChild();
	}
	function removeChlid(_child) {
		object_array.remove(object_array.find(_child));
		
		updateChild();
	}
}

class SpritePanel extends Panel {
	constructor(rawname, _border = 0, _margin = 0, _child_align = null) {
		local object = emo.Sprite(rawname);
		base.constructor(object, _border, _margin, _child_align);
	}
}

class RectanglePanel extends Panel {
	constructor(size_x, size_y, _border = 0, _margin = 0, _child_align = null) {
		local object = emo.Rectangle();
		object.setSize(size_x, size_y);
		base.constructor(object, _border, _margin, _child_align);
	}
}