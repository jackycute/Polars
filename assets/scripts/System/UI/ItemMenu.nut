class ItemMenu extends RectanglePanel {
	holding_item = null;
	constructor(size_x, size_y, _border = 0, _margin = 0, _child_align = null) {
		base.constructor(size_x, size_y, _border, _margin, _child_align);
	}
	function onGainedFocus() {
		this.setZ(100);
		this.color(0.5, 0.5, 0.5);
		this.move((stage.getWindowWidth() - this.getWidth())/2, (stage.getWindowHeight() - this.getHeight())/2);
	}
	function onUpTime() {
	}
	function onLostFocus() {
	}
	function onMotionEvent(mevent) {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].onMotionEvent(mevent);
		}
		//print(mevent.getAction());
		switch(mevent.getAction()) {
			case MOTION_EVENT_ACTION_UP:
				if(holding_item != null) {
					holding_item.onRelease(mevent);
					holding_item = null;
				}
			break;
			case MOTION_EVENT_ACTION_MOVE:
				if(holding_item != null) {
					holding_item.move(mevent.getX() - holding_item.getWidth()/2, mevent.getY() - holding_item.getHeight()/2);
				}
			break;
		}
	}
	function setHoldingItem(item) {
		if(holding_item != null) {
			holding_item.onRelease(mevent);
			holding_item = null;
		}
		holding_item = item;
	}
	function getHoldingItem() {
		return holding_item;
	}
	function addItem(item) {
		object_array.append(item);
		
		updateChild();
	}
	function removeItem(item) {
		object_array.remove(object_array.find(item));
		
		updateChild();
	}
	function hasItem(item) {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i].getItemId() == item.getItemId()) return true;
		}
		return false;
	}
}