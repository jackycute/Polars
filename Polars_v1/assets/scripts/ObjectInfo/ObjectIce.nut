ICE_DENSITY 			<- 1;
ICE_FRICTION 			<- 0.5;
ICE_RESTITUTION 		<- 0;
ICE_FIXROTATION 		<- false;
ICE_LINEARDAMPING		<- 0;
ICE_ALLOWSLEEP			<- true;

class SEA_ICE_MOVE_LISTENER extends SwipeListener {
	constructor() {
		base.constructor();
	}
	function onSwipeRight(speed) {
		//print("onSwipeUp(speed)");
		local objectlayer = layermanager.getLayer(OBJECT_LAYER_NUM);
		local sea_ice = objectlayer.getObject("Sea Ice Big", 1);
		sea_ice.move(sea_ice.getX() + fabs(speed.x), sea_ice.getY());
	}
	function onSwipeLeft(speed) {
		//print("onSwipeUp(speed)");
		local objectlayer = layermanager.getLayer(OBJECT_LAYER_NUM);
		local sea_ice = objectlayer.getObject("Sea Ice Big", 1);
		sea_ice.move(sea_ice.getX() - fabs(speed.x), sea_ice.getY());
	}
}

class CONNECTED_ROPE extends SpriteButton {
	jointDef = emo.physics.RevoluteJointDef();
	joint = null;
	
	sea_ice_move_listener = SEA_ICE_MOVE_LISTENER();
	constructor(rawname) {
		base.constructor(rawname);
		this.show();
	}
	function onSelect(mevent) {
		//print("CONNECTED_ROPE::onSelect()");
		if(joint == null) {
			local objectlayer = layermanager.getLayer(OBJECT_LAYER_NUM);
			local sea_ice = objectlayer.getObject("Sea Ice Big", 1);
			
			if(sea_ice.collidesWith(bear)) {
				jointDef.initialize(sea_ice.getRealSprite().getPhysicsBody(), bear.getPhysicsBody(), 
										sea_ice.getRealSprite().getPhysicsBody().getWorldCenter());
				joint = world.createJoint(jointDef);
				
				//gestureDetector.addSwipeListener(sea_ice_move_listener);
			}
		} else {
			world.destroyJoint(joint);
			joint = null;
			//gestureDetector.removeSwipeListener(sea_ice_move_listener);
		}
	}
	function onPress(mevent) {
		//print("CONNECTED_ROPE::onPress()");
		this.alpha(0.5);
	}
	function onRelease(mevent) {
		//print("CONNECTED_ROPE::onRelease()");
		this.alpha(1);
	}
	function onLongPress(mevent) {
		//print("CONNECTED_ROPE::onLongPress()");
	}
	function onMove(mevent) {
		//print("CONNECTED_ROPE::onMove()");
	}
}

OBJECT_ICE <- {
	CHIPNAME = "ice_chip.png",
	[265] = {
		name = "Sea Ice Small",
		sprite_create_method = "skinsprite",
		skinsprite = {
			sprite_create_method = "sprite",
			sprite_rawname = "SeaIce_2.png",
			using_physics = false,
			function onCreate(map, tile_coord) {
			},
			/*function onUpTime(this_object) {
				print("skinsprite::onUpTime");
			}*/
		}
		realsprite = {
			sprite_create_method = "rectangle",
			rectangle_size = [2*MAP_BLOCK_SIZE, MAP_BLOCK_SIZE],
			using_physics = true,
			physics_create_method = "static",
			fixturedef_density = ICE_DENSITY,
			fixturedef_friction = ICE_FRICTION,
			fixturedef_restitution = ICE_RESTITUTION,
			bodydef_fixrotation = ICE_FIXROTATION,
			bodydef_lineardamping = ICE_LINEARDAMPING,
			bodydef_allowsleep = ICE_ALLOWSLEEP,
			function onCreate(map, tile_coord) {
			},
			/*function onUpTime(this_object) {
				print("realsprite::onUpTime");
			}*/
		},
		align_x = HORIZONTAL_ALIGH.CENTER,
		align_y = VERTICAL_ALIGH.BOTTOM,
		function onCreate(map, tile_coord) {
		},
		function onUpTime(this_object) {
			//this_object.getRealSprite().hide();
			//this_object.getSkinSprite().hide();
			
			this_object.move(this_object.getX(), this_object.getY());
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			if(fixtureA.id == bear.getFixture().id || fixtureB.id == bear.getFixture().id)
				if(normal.y == -1)  bear.setPhysicsStatus(BEAR_PHYSICS_STATUS.CONTACTED);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onMotionEvent(this_object, mevent) {
		},
		function onPreview(this_object) {
		},
		function onCancel(this_object) {
		},
		function onCombine(this_object) {
		}
	},
	[260] = {
		name = "Sea Ice Big",
		sprite_create_method = "skinsprite",
		skinsprite = {
			sprite_create_method = "sprite",
			sprite_rawname = "SeaIce_1.png",
			using_physics = false,
			function onCreate(map, tile_coord) {
			},
			/*function onUpTime(this_object) {
				print("skinsprite::onUpTime");
			}*/
		}
		realsprite = {
			sprite_create_method = "rectangle",
			rectangle_size = [3*MAP_BLOCK_SIZE, MAP_BLOCK_SIZE],
			using_physics = true,
			physics_create_method = "dynamic",
			fixturedef_density = ICE_DENSITY,
			fixturedef_friction = ICE_FRICTION,
			fixturedef_restitution = ICE_RESTITUTION,
			bodydef_fixrotation = ICE_FIXROTATION,
			bodydef_lineardamping = ICE_LINEARDAMPING,
			bodydef_allowsleep = ICE_ALLOWSLEEP,
			function onCreate(map, tile_coord) {
			},
			/*function onUpTime(this_object) {
				print("realsprite::onUpTime");
			}*/
		},
		align_x = HORIZONTAL_ALIGH.CENTER,
		align_y = VERTICAL_ALIGH.BOTTOM,
		function onCreate(map, tile_coord) {
		},
		function onUpTime(this_object) {
			//this_object.getRealSprite().hide();
			//this_object.getSkinSprite().hide();
			
			this_object.move(this_object.getX(), this_object.getY());
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			if(fixtureA.id == bear.getFixture().id || fixtureB.id == bear.getFixture().id)
				if(normal.y == -1)  bear.setPhysicsStatus(BEAR_PHYSICS_STATUS.CONTACTED);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onMotionEvent(this_object, mevent) {
		},
		function onPreview(this_object) {
		},
		function onCancel(this_object) {
		},
		function onCombine(this_object) {
		}
	},
	[311] = {
		name = "Icicle Left",
		sprite_create_method = "skinsprite",
		skinsprite = {
			sprite_create_method = "self_construct",
			using_physics = false,
			function constructor(map, tile_coord) {
				return null;
			}
			function onCreate(map, tile_coord) {
			}
		}
		realsprite = {
			sprite_create_method = "sprite",
			sprite_rawname = "Icicle_Left.png",
			using_physics = false,
			function onCreate(map, tile_coord) {
			}
		},
		align_x = HORIZONTAL_ALIGH.CENTER,
		align_y = VERTICAL_ALIGH.BOTTOM,
		ICICLE_STATE = {
			NORMAL = 0,
			ROPED = 1,
			DONE = 2
		},
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_object) {
			//print("Icicle::onUpTime");
			local holdingitem = ui.getItemMenu().getHoldingItem();
			if(holdingitem != null && holdingitem.getItemInfo().name == "Rope") {
				if(GuiCollidesWith(holdingitem.getObject(), this_object.getRealSprite())) {
					if(this_object.getState() == OBJECT_STATE.NOTHING) {
						this_object.onPreview();
						holdingitem.setDeployable(true, this_object);
					}
				} else if(this_object.getState() == OBJECT_STATE.PREVIEWING) {
					this_object.onCancel();
					holdingitem.setDeployable(false);
				}
			}
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onMotionEvent(this_object, mevent) {
			local realsprite = this_object.getRealSprite();
			if(this_object.getState() == OBJECT_STATE.COMBINED && this_object.getCustomState() != this.ICICLE_STATE.DONE) {
				switch(mevent.getAction()) {
					case MOTION_EVENT_ACTION_DOWN:
					if(realsprite.contains(mevent.getX() + Camera_X, mevent.getY() + Camera_Y)) {
						realsprite.alpha(0.5);
						ui.getItemMenu().setDrawingLine(true, emo.Vec2(mevent.getX(), mevent.getY()));
						ui.getItemMenu().setTag("Left");
						//ui.getItemMenu().setCallBack(this_object);
					}
					break;
					case MOTION_EVENT_ACTION_UP:
						realsprite.alpha(1);
						ui.getItemMenu().setDrawingLine(false);
						if(ui.getItemMenu().getTag() == "Left") ui.getItemMenu().setTag(null);
					break;
				}
				if(ui.getItemMenu().getTag() == "Connected") {
					//print("GET!");
					this_object.setCustomState(this.ICICLE_STATE.DONE);
					//realsprite.alpha(1);
					//ui.getItemMenu().setDrawingLine(false);
					ui.getItemMenu().setTag(null);
				}
			}
		},
		function onPreview(this_object) {
			//print("Icicle::onPreview");
			local newObject = emo.Sprite("Icicle_Left_onRope.png");
			newObject.alpha(0.5);
			this_object.changeRealSprite(newObject);
		},
		function onCancel(this_object) {
			//print("Icicle::onCancel");
			local newObject = emo.Sprite("Icicle_Left.png");
			newObject.alpha(1);
			this_object.changeRealSprite(newObject);
		},
		function onCombine(this_object) {
			//print("Icicle::onCombine");
			local newObject = emo.Sprite("Icicle_Left_onRope.png");
			newObject.alpha(1);
			newObject.load();
			this_object.changeRealSprite(newObject);
			this_object.setCustomState(this.ICICLE_STATE.ROPED);
		}
	},
	[316] = {
		name = "Icicle Right",
		sprite_create_method = "skinsprite",
		skinsprite = {
			sprite_create_method = "self_construct",
			using_physics = false,
			function constructor(map, tile_coord) {
				return null;
			}
			function onCreate(map, tile_coord) {
			}
		}
		realsprite = {
			sprite_create_method = "sprite",
			sprite_rawname = "Icicle_Right.png",
			using_physics = false,
			function onCreate(map, tile_coord) {
			}
		},
		align_x = HORIZONTAL_ALIGH.CENTER,
		align_y = VERTICAL_ALIGH.BOTTOM,
		ICICLE_STATE = {
			NORMAL = 0,
			ROPED = 1,
			DONE = 2
		},
		connected_rope = null,
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_object) {
			if(this.connected_rope != null) connected_rope.onUpTime();
			/*local holdingitem = ui.getItemMenu().getHoldingItem();
			if(holdingitem != null && holdingitem.getItemInfo().name == "Rope") {
				if(GuiCollidesWith(holdingitem.getObject(), this_object.getRealSprite())) {
					if(this_object.getState() == OBJECT_STATE.NOTHING) {
						this_object.onPreview();
						holdingitem.setDeployable(true, this_object);
					}
				} else if(this_object.getState() == OBJECT_STATE.PREVIEWING) {
					this_object.onCancel();
					holdingitem.setDeployable(false);
				}
			}*/
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onMotionEvent(this_object, mevent) {
			if(this.connected_rope != null) connected_rope.onMotionEvent(mevent);
			
			local realsprite = this_object.getRealSprite();
			if(ui.getItemMenu().getTag() == "Left" && this_object.getCustomState() != this.ICICLE_STATE.DONE)
				switch(mevent.getAction()) {
					case MOTION_EVENT_ACTION_DOWN:
					
					break;
					case MOTION_EVENT_ACTION_UP:
						if(realsprite.contains(mevent.getX() + Camera_X, mevent.getY() + Camera_Y)) {
							local newObject = emo.Sprite("Icicle_Right_onRope.png");
							newObject.alpha(1);
							this_object.changeRealSprite(newObject);
							this_object.setCustomState(this.ICICLE_STATE.DONE);
							this_object.onCombine();
							//ui.getItemMenu().getCallBack().setCustomState(this.ICICLE_STATE.DONE);
							//ui.getItemMenu().setCallBack(null);
							ui.getItemMenu().setTag("Connected");
							
							this.connected_rope = CONNECTED_ROPE("rope_connected.png");
							connected_rope.move(this_object.getX() + this_object.getWidth() - 30, this_object.getY() + this_object.getHeight()/2 + 30);
							connected_rope.setZ(this_object.getZ()-1);
							connected_rope.load();
						} else {
							local newObject = emo.Sprite("Icicle_Right.png");
							newObject.alpha(1);
							this_object.changeRealSprite(newObject);
						}
					break;
					case MOTION_EVENT_ACTION_MOVE:
						if(realsprite.contains(mevent.getX() + Camera_X, mevent.getY() + Camera_Y)) {
							local newObject = emo.Sprite("Icicle_Right_onRope.png");
							newObject.alpha(0.5);
							this_object.changeRealSprite(newObject);
						} else {
							local newObject = emo.Sprite("Icicle_Right.png");
							newObject.alpha(1);
							this_object.changeRealSprite(newObject);
						}
					break;
				}
		},
		function onPreview(this_object) {
			print("Icicle::onPreview");
			//local newObject = emo.Sprite("Icicle_Right_onRope.png");
			//newObject.alpha(0.5);
			//this_object.changeRealSprite(newObject);
		},
		function onCancel(this_object) {
			print("Icicle::onCancel");
			//local newObject = emo.Sprite("Icicle_Right.png");
			//newObject.alpha(1);
			//this_object.changeRealSprite(newObject);
		},
		function onCombine(this_object) {
			print("Icicle::onCombine");
			//local newObject = emo.Sprite("Icicle_Right_onRope.png");
			//newObject.alpha(1);
			//newObject.load();
			//this_object.changeRealSprite(newObject);
			//this_object.setCustomState(this.ICICLE_STATE.ROPED);
		}
	}
}