class RecycleRobot extends Manager {
	constructor(_period = 0) {
		base.constructor(_period);
	}
	function objectEvent() {
		for(local i = 0; i < object_array.len(); i++) {
			if(object_array[i] != null) {
				local sprite = object_array[i];
				//this.RemovePhysicsInfo(sprite);
			    sprite.remove();
			}
		}
	}
	function RemovePhysicsInfo(sprite) {
		if (sprite.getPhysicsInfo() != null) {
	    	sprite.getPhysicsInfo().remove();
	        sprite.physicsInfo = null;
	    }
	}
}