class Manager {
	object_array = null;
	last_uptime = 0;
	current_uptime = 0;
	period = 0;
	
	isLoaded = false;
	constructor(_period = 0) {
		period = _period;
		local newArray = [];
		object_array = newArray;
	}
	function getObjectArray() {
		return object_array;
	}
	function isLoaded() {
		return isLoaded;
	}
	function load() {
		for(local i = 0; i < object_array.len(); i++)
			if(object_array[i] != null) object_array[i].load();
		isLoaded = true;
	}
	function remove(object = null) {
		if(object != null) {
			if(object_array.find(object) != null) {
				local newArray = [];
				for(local i = 0; i < object_array.len(); i++)
					if(object_array[i] != object) newArray.append(object_array[i]);
				object_array = newArray;
				
				object.remove();
				obejct = null;
			}
		} else {
			for(local i = 0; i < object_array.len(); i++)
				if(object_array[i] != null) {
					object_array[i].remove();
					object_array[i] = null;
				}
			object_array.clear();
		}
	}
	function onUpTime() {
		if(runtime.uptime() - last_uptime > period)
			objectEvent();
			
		last_uptime = current_uptime;
		current_uptime = runtime.uptime();
	}
	function addObject(object) {
		object_array.append(object);
	}
	function objectEvent() {
		print("Manager::objectEvent()");
	}
}

class LayerManager extends Manager {
	constructor(_period = 0) {
		base.constructor(_period);
	}
	function getMaxWidth() {
		local maxwidth = 0;
		for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		maxwidth = (object_array[i].getWidth() > maxwidth ? object_array[i].getWidth() : maxwidth);
        	}
        }
        return maxwidth;
	}
	function getminWidth() {
		local minwidth = this.getMaxWidth();
		for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		minwidth = (object_array[i].getWidth() < minwidth ? object_array[i].getWidth() : minwidth);
        	}
        }
        return minwidth;
	}
	function getMaxHeight() {
		local maxheight = 0;
		for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		maxheight = (object_array[i].getHeight() > maxheight ? object_array[i].getHeight() : maxheight);
        	}
        }
        return maxheight;
	}
	function getminHeight() {
		local minheight = this.getMaxHeight();
		for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		minheight = (object_array[i].getHeight() < minheight ? object_array[i].getHeight() : minheight);
        	}
        }
        return minheight;
	}
	function objectEvent() {
		for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		object_array[i].onUpTime();
        	}
        }
	}
	function onContact(state, fixtureA, fixtureB, 
            position, normal, normalImpulse, tangentImpulse) {
    	for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		object_array[i].onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
        	}
        }	
	}
	function onImpact(fixtureA, fixtureB,
            position, normal, normalImpulse, tangentImpulse) {
        for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null) {
        		object_array[i].onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
        	}
        }		
	}
}

class TileManager extends Manager {
	tileinfo_array = [];
	constructor(_period = 0) {
		local newArray = [];
		tileinfo_array = newArray;
		
		base.constructor(_period);
	}
	function objectEvent() {
		//print("object_array.len(): " + object_array.len());
		for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i] != null && object_array[i].isLoaded()) {
        		tileinfo_array[i].onUpTime(object_array[i]);
        	}
        }
	}
	function addObject(object, tileinfo) {
		object_array.append(object);
		tileinfo_array.append(tileinfo);
	}
	function remove(object = null) {
		if(object != null) {
			if(object_array.find(object) != null) {
				local newArray = [];
				local newInfoArray = [];
				for(local i = 0; i < object_array.len(); i++) {
					if(object_array[i] != object) {
						newArray.append(object_array[i]);
						newInfoArray.append(tileinfo_array[i]);
					}
				}
				object_array = newArray;
				tileinfo_array = newInfoArray;
				
				object.remove();
				obejct = null;
			}
		} else {
			for(local i = 0; i < object_array.len(); i++)
				if(object_array[i] != null) {
					object_array[i].remove();
					object_array[i] = null;
				}
			object_array.clear();
			tileinfo_array.clear();
		}
	}
}

class PhysicsTileManager extends TileManager {
	constructor(_period = 0) {
		base.constructor(_period);
	}
	function onContact(state, fixtureA, fixtureB, 
            position, normal, normalImpulse, tangentImpulse) {
    	for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i]!=null && object_array[i].isLoaded()) {
        		local temp_id = object_array[i].getFixture().id;
        		if(fixtureA.id == temp_id || fixtureB.id == temp_id) {
        			tileinfo_array[i].onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
        		}
        	}
        }
	}
	function onImpact(fixtureA, fixtureB,
            position, normal, normalImpulse, tangentImpulse) {
    	// get the event coordinate
        local x = position.x * world.getScale();
        local y = position.y * world.getScale();
        
        for(local i = 0; i < object_array.len(); i++) {
        	if(object_array[i]!=null && object_array[i].isLoaded()) {
        		local temp_id = object_array[i].getFixture().id;
        		if(fixtureA.id == temp_id || fixtureB.id == temp_id) {
        			tileinfo_array[i].onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
        		}
        	}
        }
	}
}