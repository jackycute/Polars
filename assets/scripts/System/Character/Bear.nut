BEAR_PNG_RAWNAME 				<- "Bear_2.png";
BEAR_PNG_WIDTH 					<- 73;
BEAR_PNG_HEIGHT 				<- 128;
BEAR_PNG_BORDER 				<- 0;
BEAR_PNG_MARGIN 				<- 0;

BEAR_DEFAULT_POS_X 				<- stage.getWindowWidth()/2;
BEAR_DEFAULT_POS_Y 				<- stage.getWindowHeight()/2;
BEAR_DEFAULT_Z					<- 40;

BEAR_PHYSICS_FIXDROTATION 		<- true;
BEAR_PHYSICS_LINEARDAMPING 		<- 0;
BEAR_PHYSICS_ALLOW_SLEEP 		<- false;
BEAR_PHYSICS_DENSITY 			<- 0.9;
BEAR_PHYSICS_FRICTION			<- 0.5;
BEAR_PHYSICS_RESTITUTION 		<- 0;

BEAR_PHYSICS_ONAIR_THRESHOLD	<- 1;
BEAR_PHYSICS_JUMPING_THRESHOLD	<- 0;
BEAR_PHYSICS_FALLING_THRESHOLD	<- 0;

BEAR_PHYSICS_STAND_ANGLE_RANGE 	<- 0;
BEAR_PHYSICS_STILL_THRESHOLD 	<- 0;

BEAR_PHYSICS_RUN_THRESHOLD 		<- 8;
BEAR_PHYSICS_RUN_LIMIT 			<- 10;

BEAR_TO_BORING_TIME_THRESHOLD 	<- 5;		//sec
BEAR_TO_FRONT_TIME_THRESHOLD	<- 1;		//sec

BEAR_DEAFULT_FRAME_INTERVAL 	<- 100;		//millionsec
BEAR_WALK_FRAME_INTERVAL 		<- 100;		//millionsec
BEAR_RUN_FRAME_INTERVAL			<- 50;		//millionsec

BEAR_LEFT_FIRST_FRAMEINDEX 		<- 0;
BEAR_LEFT_LAST_FRAMEINDEX 		<- 7;
BEAR_RIGHT_FIRST_FRAMEINDEX		<- 9;
BEAR_RIGHT_LAST_FRAMEINDEX		<- 16;
BEAR_FRONT_FRAMEINDEX 			<- 8;
BEAR_BORING_FRAMEINDEX			<- 17;

BEAR_SENSOR_MOVE_THRESHOLD		<- 0.1;
BEAR_SENSOR_MOVE_LIMIT			<- 0.2;
BEAR_MOVE_SPEED_Y				<- 15;

BEAR_JUMP_SPEED_X				<- 10;

enum BEAR_DIRECTION_STATUS {
	LEFT, RIGHT, FRONT, BACK
}

enum BEAR_MOTION_STATUS {
	BORING, IDLE, STILL, JUMPING, FALLING, WALK, RUN
}

enum BEAR_PHYSICS_STATUS {
	CONTACTED, ONAIR
}

enum BEAR_LIFE_STATUS {
	NORMAL, DAMAGED, SUPER, DIE
}

class BEAR_IDLE_TIMER extends Timer {
    constructor(_total_interval, _tick_interval) {
    	base.constructor(_total_interval, _tick_interval);
    }
    function onTick(ticks) {
    	if(ticks == 1 && bear.getDirectionStatus() != BEAR_DIRECTION_STATUS.FRONT)
    		bear.setDirectionStatus(BEAR_DIRECTION_STATUS.FRONT);
    	//	bear_direction_status = BEAR_DIRECTION_STATUS.FRONT;
		//print("onTick()");
	}
	function onFinish() {
		if(bear.getMotionStatus() != BEAR_MOTION_STATUS.BORING)
			bear.setMotionStatus(BEAR_MOTION_STATUS.BORING);
		//bear_motion_status = BEAR_MOTION_STATUS.BORING;
		//print("onFinish()");
	}
}

class BEAR_MOVE_LISTENER extends AccelerometerListener {
	constructor() {
		base.constructor();
	}
	function onEvent(sevent) {
		bear.onAccelerometerEvent(sevent);
	}
}

class BEAR_JUMP_LISTENER extends SwipeListener {
	constructor() {
		base.constructor();
	}
	function onSwipeUp(speed) {
		//print("onSwipeUp(speed)");
		bear.onSwipeUpEvent(speed);
	}
}

class Bear extends emo.SpriteSheet {
	bear_physics_staus 			= BEAR_PHYSICS_STATUS.ONAIR;
    bear_motion_status 			= BEAR_MOTION_STATUS.IDLE;
    last_bear_motion_status 	= null;
    bear_direction_status 		= BEAR_DIRECTION_STATUS.RIGHT;
    last_bear_direction_status 	= null;
    bear_life_status			= BEAR_LIFE_STATUS.NORMAL;
    last_bear_life_status		= null;
    
    bear_fixtureDef 			= emo.physics.FixtureDef();
    bear_bodyDef 				= emo.physics.BodyDef();
    
    startFrameIndex 			= 0;
	endFrameIndex				= 0;
	
	bear_idle_timer 			= null;
	
	BEAR_MOTION_FRAMEINDEX 		= GenerateFrameArray(0, 17)// <- [0, 4, 7, 8, 9, 12, 16, 17];
	
	bear_move_listener 			= BEAR_MOVE_LISTENER();
	bear_jump_listener 			= BEAR_JUMP_LISTENER();
	
	constructor() {
		base.constructor(BEAR_PNG_RAWNAME, BEAR_PNG_WIDTH, BEAR_PNG_HEIGHT, BEAR_PNG_BORDER, BEAR_PNG_MARGIN);
	}
	function Init(_x = BEAR_DEFAULT_POS_X, _y = BEAR_DEFAULT_POS_Y, _z = BEAR_DEFAULT_Z) {
		
		this.move(_x, _y);
		this.setZ(_z);
		
		bear_bodyDef.fixedRotation = BEAR_PHYSICS_FIXDROTATION;
        bear_bodyDef.linearDamping = BEAR_PHYSICS_LINEARDAMPING;
        bear_bodyDef.allowSleep = BEAR_PHYSICS_ALLOW_SLEEP;
        
        bear_fixtureDef.density  = BEAR_PHYSICS_DENSITY;
        bear_fixtureDef.friction = BEAR_PHYSICS_FRICTION;
        bear_fixtureDef.restitution = BEAR_PHYSICS_RESTITUTION;
        physics.createDynamicSprite(world, this, bear_fixtureDef, bear_bodyDef);
        
        sensorDetector.addAccelerometerListener(bear_move_listener);
        gestureDetector.addSwipeListener(bear_jump_listener);
		
		this.load();
	}
	function onGameLoop() {
		if(bear_idle_timer != null) bear_idle_timer.onUpTime();
		
		UpdateStatus();
		UpdateAnimate();
	}
	function UpdateStatus() {
        local bearBody = this.getPhysicsInfo().getBody();
        local Current_Velocity = bearBody.getLinearVelocity();
        /*local point = emo.Vec2(bearBody.getPosition().x, bearBody.getPosition().y);       
        local force = emo.Vec2( controlX, controlY);
        bearBody.applyForce(force, point);*/
        //if(Current_Velocity.y <= 0.001 || Current_Velocity.y >= -0.001) bear_physics_staus = BEAR_PHYSICS_STATUS.CONTACTED;
        //else 
        //print(format("X: %4.2f, Y: %4.2f", fabs(Current_Velocity.x), fabs(Current_Velocity.y)));
        if(fabs(Current_Velocity.y) > BEAR_PHYSICS_ONAIR_THRESHOLD) bear_physics_staus = BEAR_PHYSICS_STATUS.ONAIR;
        
        last_bear_motion_status = bear_motion_status;
        last_bear_direction_status = bear_direction_status;
        
        if(bear_physics_staus == BEAR_PHYSICS_STATUS.ONAIR) {
	        if(Current_Velocity.y < BEAR_PHYSICS_JUMPING_THRESHOLD)
	        	bear_motion_status = BEAR_MOTION_STATUS.JUMPING;//print("JUMPING!");
	        else if(Current_Velocity.y > BEAR_PHYSICS_FALLING_THRESHOLD)
	        	bear_motion_status = BEAR_MOTION_STATUS.FALLING;
        } else if(bear_physics_staus == BEAR_PHYSICS_STATUS.CONTACTED)
			if(bearBody.getAngle() <= BEAR_PHYSICS_STAND_ANGLE_RANGE) {
				/*if(fabs(Current_Velocity.x) > BEAR_PHYSICS_RUN_LIMIT) {
					if(Current_Velocity.x > 0) bearBody.setLinearVelocity(emo.Vec2(BEAR_PHYSICS_RUN_LIMIT, Current_Velocity.y));
					else if(Current_Velocity.x < 0) bearBody.setLinearVelocity(emo.Vec2(-BEAR_PHYSICS_RUN_LIMIT, Current_Velocity.y));
				}*/
				if(fabs(Current_Velocity.x) <= BEAR_PHYSICS_STILL_THRESHOLD) {
					//print("(Current_Velocity.x) <= 0.1");
					if(bear_motion_status != BEAR_MOTION_STATUS.BORING) bear_motion_status = BEAR_MOTION_STATUS.STILL;
					if(bear_idle_timer == null) {
						print("bear_idle_timer.start()");
						bear_idle_timer = BEAR_IDLE_TIMER(BEAR_TO_BORING_TIME_THRESHOLD*1000, 1000);
						bear_idle_timer.start();
					}/* else if(bear_idle_timer.getElapsedTime() >= BEAR_TO_FRONT_TIME_THRESHOLD && bear_direction_status != BEAR_DIRECTION_STATUS.FRONT) {
							print("BEAR_DIRECTION_STATUS.FRONT");
							bear_direction_status = BEAR_DIRECTION_STATUS.FRONT;
					} else if(bear_idle_timer.getFinished() && bear_motion_status != BEAR_MOTION_STATUS.BORING) {
							print("BEAR_MOTION_STATUS.BORING");
							bear_motion_status = BEAR_MOTION_STATUS.BORING;
					}*/
				} else {
					if(bear_idle_timer != null) bear_idle_timer = bear_idle_timer.remove();
					if(fabs(Current_Velocity.x) <= BEAR_PHYSICS_RUN_THRESHOLD) bear_motion_status = BEAR_MOTION_STATUS.WALK;
					else if(fabs(Current_Velocity.x) > BEAR_PHYSICS_RUN_THRESHOLD) bear_motion_status = BEAR_MOTION_STATUS.RUN;
					if(Current_Velocity.x < 0) bear_direction_status = BEAR_DIRECTION_STATUS.LEFT;
					else if(Current_Velocity.x > 0) bear_direction_status = BEAR_DIRECTION_STATUS.RIGHT;
				}
				
			}
	}
	function UpdateAnimate() {
		if((last_bear_motion_status != bear_motion_status) || (last_bear_direction_status != bear_direction_status)) {
			local interval = BEAR_DEAFULT_FRAME_INTERVAL;
			local loop = -1;
			local FrameArray = [];
			//print("bear_motion_status: " + bear_motion_status);
		switch(bear_motion_status) {
			case BEAR_MOTION_STATUS.BORING:
				switch(bear_direction_status) {
					case BEAR_DIRECTION_STATUS.FRONT:
						startFrameIndex = endFrameIndex = BEAR_BORING_FRAMEINDEX;
					break;
				}
			break;
			case BEAR_MOTION_STATUS.STILL:
				switch(bear_direction_status) {
					case BEAR_DIRECTION_STATUS.FRONT:
						startFrameIndex = endFrameIndex = BEAR_FRONT_FRAMEINDEX;
					break;
					case BEAR_DIRECTION_STATUS.LEFT:
						startFrameIndex = endFrameIndex = BEAR_LEFT_FIRST_FRAMEINDEX;
					break;
					case BEAR_DIRECTION_STATUS.RIGHT:
						startFrameIndex = endFrameIndex = BEAR_RIGHT_LAST_FRAMEINDEX;
					break;
				}
			break;
			case BEAR_MOTION_STATUS.WALK:
				interval = BEAR_WALK_FRAME_INTERVAL;
				switch(bear_direction_status) {
					case BEAR_DIRECTION_STATUS.LEFT:
						startFrameIndex = BEAR_LEFT_FIRST_FRAMEINDEX;
						endFrameIndex = BEAR_LEFT_LAST_FRAMEINDEX;
					break;
					case BEAR_DIRECTION_STATUS.RIGHT:
						startFrameIndex = BEAR_RIGHT_FIRST_FRAMEINDEX;
						endFrameIndex = BEAR_RIGHT_LAST_FRAMEINDEX;
					break;
				}
			break;
			case BEAR_MOTION_STATUS.RUN:
				interval = BEAR_RUN_FRAME_INTERVAL;
				switch(bear_direction_status) {
					case BEAR_DIRECTION_STATUS.LEFT:
						startFrameIndex = BEAR_LEFT_FIRST_FRAMEINDEX;
						endFrameIndex = BEAR_LEFT_LAST_FRAMEINDEX;
					break;
					case BEAR_DIRECTION_STATUS.RIGHT:
						startFrameIndex = BEAR_RIGHT_FIRST_FRAMEINDEX;
						endFrameIndex = BEAR_RIGHT_LAST_FRAMEINDEX;
					break;
				}
			break;
		}
			FrameArray = GenerateFrameArray(startFrameIndex, endFrameIndex);
			if(this.getFrameIndex() > startFrameIndex && this.getFrameIndex() < endFrameIndex) {
				local tempFrameArray = GenerateFrameArray(this.getFrameIndex()+1, endFrameIndex);
				tempFrameArray.extend(GenerateFrameArray(startFrameIndex, this.getFrameIndex()));
				FrameArray = tempFrameArray;
			}
			if((last_bear_direction_status ==  BEAR_DIRECTION_STATUS.LEFT && bear_direction_status == BEAR_DIRECTION_STATUS.RIGHT)
				|| (last_bear_direction_status ==  BEAR_DIRECTION_STATUS.RIGHT && bear_direction_status == BEAR_DIRECTION_STATUS.LEFT)) {
				//startFrameIndex = 8;
				//endFrameIndex = 8;
				local tempFrameArray = [];
				for(local i=0; i<5; i++)
					tempFrameArray.append(BEAR_FRONT_FRAMEINDEX);
				FrameArray = tempFrameArray;
				bear_direction_status = BEAR_DIRECTION_STATUS.FRONT;
			}
			if(startFrameIndex == endFrameIndex) this.pauseAt(startFrameIndex);
			else this.animate(FrameArray, 0, interval, loop);
			/*local line = "";
			for(local i=0; i<FrameArray.len(); i++) {
				line += FrameArray[i];
				line += " ";
			}
			print(line);*/
		}
	}
	function setPhysicsStatus(status) {
		bear_physics_staus = status;
	}
	function getPhysicsStatus() {
		return bear_physics_staus;
	}
	function setMotionStatus(status) {
		last_bear_motion_status = bear_motion_status;
		bear_motion_status = status;
		UpdateAnimate();
	}
	function getMotionStatus() {
		return bear_motion_status;
	}
	function setDirectionStatus(status) {
		last_bear_direction_status = bear_direction_status;
    	bear_direction_status = status;
    	UpdateAnimate();
	}
	function getDirectionStatus() {
    	return bear_direction_status;
	}
	function setLifeStatus(status) {
		last_bear_life_status = bear_life_status;
    	bear_life_status = status;
    	UpdateAnimate();
	}
	function getLifeStatus() {
    	return bear_life_status;
	}
	function onAccelerometerEvent(sevent) {
		//bear.rotate(emo.toDegree(sevent.getAccelerationX()));
        if(director.getGameState() == GAME_STATE.PLAYING && bear_physics_staus == BEAR_PHYSICS_STATUS.CONTACTED) {// && isMotionFrame(bear.getFrameIndex())
          	local bearBody = bear.getPhysicsInfo().getBody();
	        local point = emo.Vec2(bearBody.getLocalCenter().x, bearBody.getLocalCenter().y);
	          
	        local impluse = emo.Vec2(0, 0);
	           
	        //if(sevent.getAccelerationY() > 0) bear_direction_status = BEAR_DIRECTION_STATUS.LEFT;
			//else if(sevent.getAccelerationY() < 0) bear_direction_status = BEAR_DIRECTION_STATUS.RIGHT;
			
            if(fabs(sevent.getAccelerationY()) >= BEAR_SENSOR_MOVE_THRESHOLD) {
            	impluse.x = -sevent.getAccelerationY()*BEAR_MOVE_SPEED_Y*bearBody.getMass();
            } else if(fabs(sevent.getAccelerationY()) >= BEAR_SENSOR_MOVE_LIMIT) {
            	if(sevent.getAccelerationY() > 0) impluse.x = BEAR_SENSOR_MOVE_LIMIT*BEAR_MOVE_SPEED_Y*bearBody.getMass();
				else if(sevent.getAccelerationY() < 0) impluse.x = -BEAR_SENSOR_MOVE_LIMIT*BEAR_MOVE_SPEED_Y*bearBody.getMass();
            }// else impluse = emo.Vec2(0, 0);
	        bearBody.applyLinearImpulse(impluse, point);
	        //print("AccelerationY: " + sevent.getAccelerationY());
	    	//changeText(sevent.getAccelerationX(), sevent.getAccelerationY());
	    	local Current_Velocity = bearBody.getLinearVelocity();
        	if(fabs(Current_Velocity.x) > BEAR_PHYSICS_RUN_LIMIT) {
				if(Current_Velocity.x > 0) bearBody.setLinearVelocity(emo.Vec2(BEAR_PHYSICS_RUN_LIMIT, Current_Velocity.y));
				else if(Current_Velocity.x < 0) bearBody.setLinearVelocity(emo.Vec2(-BEAR_PHYSICS_RUN_LIMIT, Current_Velocity.y));
			}
    	}
	}
	function onSwipeUpEvent(speed) {
		if(director.getGameState() == GAME_STATE.PLAYING && bear_physics_staus == BEAR_PHYSICS_STATUS.CONTACTED) {
    		//print("BEAR " + "X: " + bear.getX() + " " + bear.getY() + " " + "WIDTH: " + bear.getWidth() + " " + "HEIGHT: " + bear.getHeight());
           	local bearBody = this.getPhysicsInfo().getBody();
           	local point = emo.Vec2(bearBody.getLocalCenter().x, bearBody.getLocalCenter().y);       
        	//local force = emo.Vec2(0, -500*bearBody.getMass());
        	local impulse = emo.Vec2(0, -BEAR_JUMP_SPEED_X*bearBody.getMass());
        	bearBody.applyLinearImpulse(impulse, point);
        	print(format("JUMP::BEAR POINT X: %4.2f, Y: %4.2f FORCE X: %4.2f, Y: %4.2f", point.x, point.y, impulse.x, impulse.y));
        	
        	local Current_Velocity = bearBody.getLinearVelocity();
        	if(fabs(Current_Velocity.x) > BEAR_PHYSICS_RUN_LIMIT) {
				if(Current_Velocity.x > 0) bearBody.setLinearVelocity(emo.Vec2(BEAR_PHYSICS_RUN_LIMIT, Current_Velocity.y));
				else if(Current_Velocity.x < 0) bearBody.setLinearVelocity(emo.Vec2(-BEAR_PHYSICS_RUN_LIMIT, Current_Velocity.y));
			}
    	}
	}
	function onImpact(fixtureA, fixtureB,
            position, normal, normalImpulse, tangentImpulse) {
		        // get the event coordinate
        local x = position.x * world.getScale();
        local y = position.y * world.getScale();
        
       	//if(fixtureA.id == this.getFixture().id || fixtureB.id == this.getFixture().id) bear_physics_staus = BEAR_PHYSICS_STATUS.CONTACTED;
        //else bear_physics_staus = BEAR_PHYSICS_STATUS.ONAIR;
        //bear_physics_staus = BEAR_PHYSICS_STATUS.ONAIR;
        
        /*for(local i=0; i<stone_array.len(); i++)
        	if(stone_array[i]!=null && stone_array[i].isLoaded()) {
        		local bear_id = this.getFixture().id;
        		local stone_id = stone_array[i].getFixture().id;
        		if((fixtureA.id == bear_id && fixtureB.id == stone_id) ||
        			(fixtureA.id == stone_id && fixtureB.id == bear_id)) {
        				bear_physics_staus = BEAR_PHYSICS_STATUS.CONTACTED;
        				if(this.contains(x, y)) {
        					//Bear get normal force.
        					//print(format("PHYSICS_STATE_IMPACT normal x=%4.5f normal y=%4.5f", normal.x, normal.y));
        					//bear_physics_staus = BEAR_PHYSICS_STATUS.ONAIR;
        				}// else if(normal.y == -1) bear_physics_staus = BEAR_PHYSICS_STATUS.CONTACTED;
	        			print(
	            			format("PHYSICS_STATE_IMPACT normalImpulse=%4.5f, tangentImpulse=%4.5f, x=%4.2f, y=%4.2f", 
	            			 normalImpulse, tangentImpulse, x, y));
        		}
        	}*/
	}
	function isMotionFrame(FrameIndex) {
		return BEAR_MOTION_FRAMEINDEX.find(FrameIndex);
	}
	function remove() {
		if(bear_move_listener != null) bear_move_listener.remove();
		if(bear_jump_listener != null) bear_jump_listener.remove();
		if(bear_idle_timer != null) bear_idle_timer.remove();
		stage.remove(id);
	}
}