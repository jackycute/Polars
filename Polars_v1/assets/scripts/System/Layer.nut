class Layer {
	object = null;
	object_array = null;
	
	width = 0;
	height = 0;

	columnCount = 0;
	rowCount = 0;

	isVisible = false;
	isGui = false;
	isLoaded = false;
	
	x = 0;
	y = 0;
	z = 0;
	
	red = 1;
	green = 1;
	blue = 1;
	alpha = 1;
	
	infiniteScroll = false;
	append_x = false;
	append_y = false;
	px = 0;
	py = 0;
	pwidth = 0;
	pheight = 0;
	speed_x = 0;
	speed_y = 0;
	constructor(_object, _x = 0, _y = 0, _z = 0) {
		x = _x;
		y = _y;
		z = _z;
		
		object = _object;
		width = object.getWidth();
		height = object.getHeight();
		object.move(_x, _y);
		object.setZ(_z);
		
		columnCount = 1;
		rowCount = 1;
		
		local newArray = [object];
		
		object_array = newArray;
		//object_array.append(object);
	}
	function newObject() {
		print("Layer::newObject()");
	}
	function getObjectArray() {
		return object_array;
	}
	function isLoaded() {
		return isLoaded;
	}
	function load() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].load();
		}
		isLoaded = true;
		isVisible = true;
	}
	function remove() {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i] != null) {
				object_array[i].remove();
				object_array[i] = null;
			}
		}
		isVisible = false;
	}
	function show() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].show();
		}
		isVisible = true;
		alpha = 1;
	}
	function hide() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].hide();
		}
		isVisible = false;
		alpha = 0;
	}
	function move(_x, _y) {
		local diff_x = _x - this.getX();
		local diff_y = _y - this.getY();
		x = _x;
		y = _y;
		
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].move(object_array[i].getX() + diff_x, object_array[i].getY() + diff_y);
		}
	}
	function setZ(_z) {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].setZ(_z);
		}
		z = _z;
	}
	function color(_r, _g, _b, _alpha = null) {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].color(_r, _g, _b, _alpha);
		}
		red = _r;
		green = _g;
		blue = _b;
		if(alpha != null) alpha = _alpha;
	}
	function setAsGui() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].setAsGui;
		}
		isGui = true;
	}
	function setInfiniteScroll(_speed_x, _speed_y, _bool = true) {
		speed_x = _speed_x;
		speed_y = _speed_y;
		infiniteScroll = _bool;
	}
	function setAppendToParent(_px, _py, _pwidth, _pheight, _append_x = true, _append_y = true) {
		px = _px;
		py = _py;
		pwidth = _pwidth;
		pheight = _pheight;
		append_x = _append_x;
		append_y = _append_y;
		
		columnCount = pwidth / width;
		if(pwidth%width != 0) columnCount++;
		if(columnCount <= 1) {
			if(columnCount == 0) columnCount++;
			if(append_x) {
				columnCount++;
			}
		}
		if(append_x) {
				columnCount++;
		}
			
		rowCount = pheight / height;
		if(pheight%height != 0) rowCount++;
		if(rowCount <= 1) {
			if(rowCount == 0) rowCount++;
			if(append_y) {
				rowCount++;
			}
		}
		if(append_y) {
				rowCount++;
		}
		
		print("columnCount: " + columnCount + " rowCount: " + rowCount);
		
		if(append_x) appendToX();
		if(append_y) appendToY();
	}
	function getX() {
		return x;
	}
	function getY() {
		return y;
	}
	function getWidth() {
		return columnCount*width;
	}
	function getHeight() {
		return rowCount*height;
	}
	function getColumnCount() {
		//return this.getWidth() / width;
		return columnCount;
	}
	function getRowCount() {
		//return this.getHeight() / height;
		return rowCount;
	}
	function Scroll(_x, _y) {
		local diff_x = _x - this.getX();
		local diff_y = _y - this.getY();

		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i] != null) {
				local newX = object_array[i].getX() + diff_x;
				local newY = object_array[i].getY() + diff_y;
				//object_array[i].move(newX, newY);
				if(speed_x < 0) {
					if(newX + width < px) {
						if(i%columnCount == 0)
							newX = object_array[i+columnCount-1].getX() + width + diff_x;
						else newX = object_array[i-1].getX() + width;
					}
				} else if(speed_x > 0) {
					if(width >= pwidth) {
						if(newX - width > px + pwidth) {
							if(i%columnCount == columnCount-1) {
								newX = object_array[i-columnCount+1].getX() - width;
								//print("CHECK 1");
							} else {
								newX = object_array[i+1].getX() - width + diff_x;
								//print("CHECK 2");
							}
						}
					} else {
						if(newX > px + pwidth) {
							if(i%columnCount == columnCount-1) {
								newX = object_array[i-columnCount+1].getX() - width;
								//print("CHECK 1");
							} else {
								newX = object_array[i+1].getX() - width + diff_x;
								//print("CHECK 2");
							}
						}
					}
				}
				if(speed_y < 0) {
					if(newY + height < py) {
						if(i < columnCount)
							newY = object_array[i+columnCount*(rowCount-1)].getY() + height + diff_y;
						else newY = object_array[i-columnCount].getY() + height;
					}
				} else if(speed_y > 0) {
					if(height >= pheight) {
						if(newY - height > py + pheight) {
							if(i/columnCount == rowCount-1)
								newY = object_array[i-columnCount*(rowCount-1)].getY() - height;
							else newY = object_array[i+columnCount].getY() - height + diff_y;
						}
					} else {
						if(newY > py + pheight) {
							if(i/columnCount == rowCount-1)
								newY = object_array[i-columnCount*(rowCount-1)].getY() - height;
							else newY = object_array[i+columnCount].getY() - height + diff_y;
						}
					}
				}
				object_array[i].move(newX, newY);
				//this.applySettings(object_array[i]);
			}
		}
	}
	function onUpTime() {
		if(infiniteScroll) {
			//this.clearOutRangeObject();
			this.Scroll(this.getX() + speed_x, this.getY() + speed_y);
			//this.clearOutRangeObject();
		}
		this.objectEvent();
	}
	function objectEvent() {
		print("Layer::objectEvent()");
	}
	/*function isInRange(sprite) {
		if(sprite.getX() > px && sprite.getX() < px + pwidth
               && sprite.getY() > py && sprite.getY() < py + pheight) return true;
        else return false;
	}
	function clearOutRangeObject() {
		local removeArray = [];
		for(local i = 0; i < object_array.len(); i++) {
			//if(speed_x > 0)
				if(object_array[i].getX() > px + pwidth) removeArray.append(object_array[i]);
			//else if(speed_x < 0)
				if(object_array[i].getX() + object_array[i].getWidth() < px) removeArray.append(object_array[i]);
			//if(speed_y > 0)
				if(object_array[i].getY() > py + pheight) removeArray.append(object_array[i]);
			//else if(speed_y < 0)
				if(object_array[i].getY() + object_array[i].getHeight() < py) removeArray.append(object_array[i]);
		}
		if(removeArray.len() > 0) {
			local newArray = [];
			for(local i = 0; i < object_array.len(); i++)
				if(removeArray.find(object_array[i]) == false) newArray.append(object_array[i]);
			object_array = newArray;
			
			for(local i = 0; i < removeArray.len(); i++) {
				removeArray[i].remove();
				removeArray[i] = null;
			}
			//removeArray.clear();
		}
	}*/
	function getRealX() {
		if(object_array.len() > 0 && object_array[0] != null) return object_array[0].getX();
		else return 0;
	}
	function getRealY() {
		if(object_array.len() > 0 && object_array[0] != null) return object_array[0].getY();
		else return 0;
	}
	function getRealColumnCount() {
		if(object_array.len() > 0 && object_array[0] != null) {
			local column = 1;
			local index_Y = object_array[0].getY();
			for(local i = 1; i < object_array.len(); i++) {
				if(object_array[i] != null)
					if(object_array[i].getY() == index_Y) column++;
			}
			return column;
		} else return 0;
	}
	function getRealRowCount() {
		if(object_array.len() > 0 && object_array[0] != null) {
			local row = 1;
			local index_X = object_array[0].getX();
			//local temp_column = getRealColumnCount();
			for(local i = 1; i < object_array.len(); i++) {
				if(object_array[i] != null)
					if(object_array[i].getX() == index_X) row++;
			}
			return row;
		} else return 0;
	}
	function getRealWidth() {
		return getRealColumnCount()*width;
	}
	function getRealHeight() {
		return getRealRowCount()*height;
	}
	function addfromFront_X() {
		local temp = newObject();
		temp.move(this.getRealX() - temp.getWidth(), this.getRealY());
		applySettings(temp);
		//temp.load();
		local newArray = [temp];
		newArray.extend(object_array);
		object_array = newArray;
	}
	function addfromBack_X() {
		local temp = newObject();
		temp.move(this.getRealX() + this.getRealWidth(), this.getRealY());
		applySettings(temp);
		//temp.load();
		object_array.append(temp);
	}
	function appendToX() {
		//print("appendToX()");
		while(this.getRealX() > px) {
			addfromFront_X();
			//print("check1: " + this.getRealColumnCount());
		}
		while(this.getRealX() + this.getRealWidth() < px + pwidth) {
			//print("check2: " + this.getRealX() + this.getRealWidth());
			addfromBack_X();
			//print("check2: " + this.getRealColumnCount());
		}
		if(this.getRealColumnCount() == 1)
			if(speed_x <= 0) {
				addfromBack_X();
			} else if(speed_x > 0) {
				addfromFront_X();
			}
		if(speed_x <= 0) {
			addfromBack_X();
		} else if(speed_x > 0) {
			addfromFront_X();
		}
		print("getRealColumnCount(): " + this.getRealColumnCount());
		//print("getRealRowCount(): " + this.getRealRowCount());
	}
	function addfromFront_Y() {
		local tempArray = [];
		for(local i = 0; i < this.getRealColumnCount(); i++) {
			if(i == 0) {
				local temp = newObject();
				temp.move(this.getRealX(), this.getRealY() - temp.getHeight());
				applySettings(temp);
				//temp.load();
				tempArray.append(temp);
			} else {
				local temp = newObject();
				temp.move(tempArray[i-1].getX() + tempArray[i-1].getWidth(), tempArray[i-1].getY());
				applySettings(temp);
				//temp.load();
				tempArray.append(temp);
			}
		}
		if(tempArray.len() > 0) {
			tempArray.extend(object_array);
			object_array = tempArray;
		}
	}
	function addfromBack_Y() {
		local tempArray = [];
		for(local i = 0; i < this.getRealColumnCount(); i++) {
			if(i == 0) {
				local temp = newObject();
				temp.move(this.getRealX(), this.getRealY() + this.getRealHeight());
				applySettings(temp);
				//temp.load();
				tempArray.append(temp);
			} else {
				local temp = newObject();
				temp.move(tempArray[i-1].getX() + tempArray[i-1].getWidth(), tempArray[0].getY());
				applySettings(temp);
				//temp.load();
				tempArray.append(temp);
			}
			//print("check4: " + this.getColumnCount());
		}
		if(tempArray.len() > 0) {
			object_array.extend(tempArray);
		}
	}
	function appendToY() {
		//print("appendToY()");
		while(this.getRealY() > py) {
			addfromFront_Y();
			//print("check3: " + this.getRealColumnCount());
		}
		while(this.getRealY() + this.getRealHeight() < py + pheight) {
			//print("check4: " + this.getRealY() + " " + this.getRealHeight());
			addfromBack_Y();
			//print("check4: " + this.getRealColumnCount());
		}
		if(this.getRealRowCount() == 1)
			if(speed_y <= 0) {
				addfromBack_Y();
			} else if(speed_y > 0) {
				addfromFront_Y();
			}
		if(speed_y <= 0) {
			addfromBack_Y();
		} else if(speed_y > 0) {
			addfromFront_Y();
		}
		//print("getRealColumnCount(): " + this.getRealColumnCount());
		print("getRealRowCount(): " + this.getRealRowCount());
	}
	function applySettings(sprite) {
		sprite.color(red, green, blue, alpha);
		sprite.setZ(z);
		if(isLoaded) {
			sprite.load();
			//if(isVisible)
			//	sprite.show();
		}
	}
	function newObject() {
		print("newObject()");
	}
}

class TMXLayer extends Layer {
	rawname = null;
	layer = 0;
	chipname = null;
	chipsize = 0;
	border = 0; 
	margin = 0;
	
	tileManager = TileManager();
	physicstileManager = PhysicsTileManager();
	
	constructor(_rawname, _layer, _chipname, _chipsize, _border, _margin, _x = 0, _y = 0, _z = 0) {
		rawname = _rawname;
		layer = _layer;
		chipname = _chipname;
		chipsize = _chipsize;
		border = _border;
		margin = _margin;
		
		local object = this.newObject();
		base.constructor(object, _x, _y, _z);
	}
	function getTileManager() {
		return tileManager;
	}
	function getPhysicsTileManager() {
		return physicstileManager;
	}
	function load() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].load();
		}
		tileManager.load();
		physicstileManager.load();
		isVisible = true;
	}
	function newObject() {
		return TMXMapSprite(rawname, layer, chipname, chipsize, border, margin);
	}
	function createTileFromMap() {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i] != null) {
				local _map = object_array[i];
    	
		    	for(local y=0; y<_map.getRowCount(); y++) {
		    		for(local x=0; x<_map.getColCount(); x++) {
		    			if(_map.getTileAt(y, x) != -1) {
		    				local temp_coord = _map.getTileCoordAtIndex(x, y);
		    				local temp = createTile(_map.getChipname(), _map, emo.Vec2(x, y));
		    				
		    				if(temp != null) {
			    				this.applySettings(temp);
			    				//temp.move(temp_coord.x, temp_coord.y);
			    				temp.setZ(z + 1);
			    				
			    				if(temp.getPhysicsInfo() != null)
			    					physicstileManager.addObject(temp, getTileInfo(_map.getChipname(), _map.getTileAt(y, x)));
			    				else tileManager.addObject(temp, getTileInfo(_map.getChipname(), _map.getTileAt(y, x)));
			    				
			    				print(format("%s[%d]::CREATE, X: %d,Y: %d", _map.getChipname(), _map.getTileAt(y, x), temp_coord.x, temp_coord.y));
		    				}// else print(format("%s[%d]::CREATE Error!", _map.getChipname(), _map.getTileAt(y, x)));
		    			}
		    		}
		    	}
			}
		}
	}
	function objectEvent() {
		tileManager.onUpTime();
		physicstileManager.onUpTime();
	}
	function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		physicstileManager.onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
	}
	function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		physicstileManager.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
	}
	function onMotionEvent(mevent) {
	}
}

class SpriteLayer extends Layer {
	rawname = null;
	using_physics = false;
	constructor(_rawname, _using_physics, _x = 0, _y = 0, _z = 0) {
		rawname = _rawname;
		using_physics = _using_physics;
		
		local object = this.newObject();
		base.constructor(object, _x, _y, _z);
	}
	function newObject() {
		local temp = emo.Sprite(rawname);
		if(using_physics) this.createPhyiscs(temp);
		return temp;
	}
	function createPhyiscs(sprite) {
		print("SpriteLayer::createPhyiscs()");
	}
	function objectEvent() {
		
	}
	function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		if(using_physics) {
			print("SpriteLayer::createPhyiscs()");
		}
	}
	function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		if(using_physics) {
			print("SpriteLayer::createPhyiscs()");
		}
	}
	function onMotionEvent(mevent) {
	}
}

class ObjectLayer extends Layer {
	rawname = null;
	layer = 0;
	chipname = null;
	chipsize = 0;
	border = 0; 
	margin = 0;
	
	objectmanager = ObjectManager();
	
	constructor(_rawname, _layer, _chipname, _chipsize, _border, _margin, _x = 0, _y = 0, _z = 0) {
		rawname = _rawname;
		layer = _layer;
		chipname = _chipname;
		chipsize = _chipsize;
		border = _border;
		margin = _margin;
		
		local object = this.newObject();
		base.constructor(object, _x, _y, _z);
	}
	function getObjectManager() {
		return objectmanager;
	}
	function load() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].load();
		}
		objectmanager.load();
		isVisible = true;
	}
	function newObject() {
		return TMXMapSprite(rawname, layer, chipname, chipsize, border, margin);
	}
	function getObject(_name, _count) {
		local tile_array = objectmanager.getObjectArray();
		local tileinfo_array = objectmanager.getTileInfoArray();
		local target_array = [];
		for(local i = 0; i < tileinfo_array.len(); i++)
			if(tileinfo_array[i].name == _name) target_array.append(tile_array[i]);
		if(target_array.len() > 0) return target_array[_count-1];
	}
	function createObjectFromMap() {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i] != null) {
				local _map = object_array[i];
    	
		    	for(local y=0; y<_map.getRowCount(); y++) {
		    		for(local x=0; x<_map.getColCount(); x++) {
		    			if(_map.getTileAt(y, x) != -1) {
		    				local temp_coord = _map.getTileCoordAtIndex(x, y);
		    				local temp = createObjectByMap(_map.getChipname(), _map, emo.Vec2(x, y));
		    				
		    				if(temp != null) {
			    				this.applySettings(temp);
			    				//temp.move(temp_coord.x, temp_coord.y);
			    				temp.setZ(z);
			    				temp.show();
			    				
			    				objectmanager.addObject(temp, getObjectInfo(_map.getChipname(), _map.getTileAt(y, x)));
			    				
			    				print(format("%s[%d]::CREATE, X: %d,Y: %d", _map.getChipname(), _map.getTileAt(y, x), temp_coord.x, temp_coord.y));
		    				}// else print(format("%s[%d]::CREATE Error!", _map.getChipname(), _map.getTileAt(y, x)));
		    			}
		    		}
		    	}
			}
		}
	}
	function objectEvent() {
		objectmanager.onUpTime();
	}
	function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		objectmanager.onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
	}
	function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		objectmanager.onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
	}
	function onMotionEvent(mevent) {
		objectmanager.onMotionEvent(mevent);
	}
}

class EventLayer extends Layer {
	rawname = null;
	layer = 0;
	chipname = null;
	chipsize = 0;
	border = 0; 
	margin = 0;
	
	eventmanager = EventManager();
	
	constructor(_rawname, _layer, _chipname, _chipsize, _border, _margin, _x = 0, _y = 0, _z = 0) {
		rawname = _rawname;
		layer = _layer;
		chipname = _chipname;
		chipsize = _chipsize;
		border = _border;
		margin = _margin;
		
		local object = this.newObject();
		base.constructor(object, _x, _y, _z);
	}
	function getEventManager() {
		return eventmanager;
	}
	function addEvent(event) {
		eventmanager.addEvent(event);
	}
	function load() {
		for(local i = 0; i < object_array.len(); i++) {
			object_array[i].load();
		}
		eventmanager.load();
		isVisible = true;
	}
	function newObject() {
		return TMXMapSprite(rawname, layer, chipname, chipsize, border, margin);
	}
	function createEventBlockFromMap() {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i] != null) {
				local _map = object_array[i];
    	
		    	for(local y=0; y<_map.getRowCount(); y++) {
		    		for(local x=0; x<_map.getColCount(); x++) {
		    			if(_map.getTileAt(y, x) != -1) {
		    				local temp_coord = _map.getTileCoordAtIndex(x, y);
		    				local temp = createEventBlockByMap(_map, emo.Vec2(x, y));
		    				
		    				if(temp != null) {
			    				this.applySettings(temp);
			    				//temp.move(temp_coord.x, temp_coord.y);
			    				temp.setZ(z);
			    				
			    				eventmanager.addEventBlock(_map.getTileAt(y, x) + 1, temp);
			    				
			    				print(format("%s[%d]::CREATE, X: %d,Y: %d", _map.getChipname(), _map.getTileAt(y, x), temp_coord.x, temp_coord.y));
		    				}// else print(format("%s[%d]::CREATE Error!", _map.getChipname(), _map.getTileAt(y, x)));
		    			}
		    		}
		    	}
			}
		}
	}
	function objectEvent() {
		eventmanager.onUpTime();
	}
	function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
	}
	function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
	}
	function onMotionEvent(mevent) {
	}
}