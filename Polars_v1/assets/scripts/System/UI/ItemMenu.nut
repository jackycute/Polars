class ItemMenu extends RectanglePanel {
	holding_item = null;
	drawingLine = false;
	drawingStartPoint = null;
	Connector = null;
	Line = null;
	tag = null;
	callback = null;
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
					if(holding_item.getDeployable()) {
						holding_item.onDeploy();
						holding_item = null;
					} else {
						holding_item.onRelease(mevent);
						holding_item.onMenu();
						if(ui.getItemMenu().isVisible()) holding_item.show();
						else holding_item.hide();
						holding_item = null;
					}
				}
			break;
			case MOTION_EVENT_ACTION_MOVE:
				if(drawingLine) {
					Line.move(drawingStartPoint.x, drawingStartPoint.y, mevent.getX(), mevent.getY());
					Line.show();
					Connector.move(mevent.getX() - Connector.getWidth()/2, mevent.getY() - Connector.getHeight()/2);
					Connector.show();
				}
				if(holding_item != null) {
					holding_item.move(mevent.getX() - holding_item.getWidth()/2, mevent.getY() - holding_item.getHeight()/2);
					if(ui.getDolphin().getObject().contains(mevent.getX(), mevent.getY())) {
						holding_item.onRelease(mevent);
						holding_item.onMenu();
						if(ui.getItemMenu().isVisible()) holding_item.show();
						else holding_item.hide();
						holding_item = null;
					}
					if(ui.getItemMenu().isVisible() && !panel_object.collidesWith(holding_item)) {
						ui.getItemMenu().hide();
						director.ResumeGame();
						
						holding_item.onStage();
					}
				}
			break;
		}
	}
	function setDrawingLine(bool, startpoint = null) {
		drawingStartPoint = startpoint;
		drawingLine = bool;
		
		if(drawingLine) {
			Connector = emo.Sprite("Connector.png");
			Connector.setZ(100);
			Connector.setAsGui();
			Connector.load();
			Connector.hide();
			Line = emo.Line();
			Line.color(0, 1, 0);
			Line.setWidth(10);
			Line.setZ(99);
			Line.setAsGui();
			Line.load();
			Line.hide();
		} else {
			if(Connector != null) {
				Connector.remove();
				Connector = null;
			}
			if(Line != null) {
				Line.remove();
				Line = null;
			}
		}
	}
	function getDrawingLine() {
		return drawingLine;
	}
	function setTag(_tag) {
		tag = _tag;
	}
	function getTag() {
		return tag;
	}
	function setCallBack(_callback) {
		callback = _callback;
	}
	function getCallBack() {
		return callback;
	}
	function setHoldingItem(item) {
		if(holding_item != null) {
			holding_item.onRelease(null);
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
		item.remove();
		
		updateChild();
	}
	function hasItem(item) {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i].getItemId() == item.getItemId()) return true;
		}
		return false;
	}
}