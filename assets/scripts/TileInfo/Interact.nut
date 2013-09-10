GROUND_DENSITY 			<- 0.9;
GROUND_FRICTION 		<- 1;
GROUND_RESTITUTION		<- 0;
GROUND_FIXROTATION		<- true;
GROUND_LINEARDAMPING	<- 0;
GROUND_ALLOWSLEEP		<- true;

WALL_DENSITY 			<- 1;
WALL_FRICTION 			<- 0;
WALL_RESTITUTION		<- 0;
WALL_FIXROTATION		<- true;
WALL_LINEARDAMPING		<- 0;
WALL_ALLOWSLEEP			<- true;

INTERACT_TILE <- {
	CHIPNAME = "interact_chip.png",
	[0] = {
		name = "Point Start",
		sprite_create_method = "rectangle",
		rectangle_size = [MAP_BLOCK_SIZE, MAP_BLOCK_SIZE],
		using_physics = false,
		function onCreate(map, tile_coord) {
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			director.setStartPoint(temp_coord);
		}
		function onUpTime(this_sprite) {
			//if(this_sprite.collidesWith(bear)) print("Hey, I'm start point!");
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[1] = {
		name = "Point End",
		sprite_create_method = "rectangle",
		rectangle_size = [MAP_BLOCK_SIZE, MAP_BLOCK_SIZE],
		using_physics = false,
		function onCreate(map, tile_coord) {
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			director.setEndPoint(temp_coord);
		}
		function onUpTime(this_sprite) {
			if(this_sprite.collidesWith(bear)) print("Hey, I'm end point!");
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	function GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		if(fixtureA.id == bear.getFixture().id || fixtureB.id == bear.getFixture().id)
				if(normal.y == -1) bear.setPhysicsStatus(BEAR_PHYSICS_STATUS.CONTACTED);
	},
	[5] = {
		name = "Single Ground"
		sprite_create_method = "rectangle",
		rectangle_size = [MAP_BLOCK_SIZE, MAP_BLOCK_SIZE],
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[2] = {
		name = "Continuous 32-Height Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local tile_width = 1;
			for(local i = tile_coord.x + 1;;i++) {
				if(map.getTileAt(tile_coord.y, i) == 3)
					tile_width++;
				else if(map.getTileAt(tile_coord.y, i) == 4) {
					tile_width++;
					local temp = emo.Rectangle();
					temp.setSize(tile_width*MAP_BLOCK_SIZE, MAP_BLOCK_SIZE);
					//print("Meet Ground End");
					local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
					temp.move(temp_coord.x, temp_coord.y);
					return temp;
				} else return null;
			}
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[18] = {
		name = "Continuous 16-Height Align-Top Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local tile_width = 1;
			for(local i = tile_coord.x + 1;;i++) {
				if(map.getTileAt(tile_coord.y, i) == 19)
					tile_width++;
				else if(map.getTileAt(tile_coord.y, i) == 20) {
					tile_width++;
					local temp = emo.Rectangle();
					temp.setSize(tile_width*MAP_BLOCK_SIZE, MAP_BLOCK_SIZE/2);
					//print("Meet Ground End");
					local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
					temp.move(temp_coord.x, temp_coord.y);
					return temp;
				} else return null;
			}
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[34] = {
		name = "Continuous 16-Height Align-Bottom Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local tile_width = 1;
			for(local i = tile_coord.x + 1;;i++) {
				if(map.getTileAt(tile_coord.y, i) == 35)
					tile_width++;
				else if(map.getTileAt(tile_coord.y, i) == 36) {
					tile_width++;
					local temp = emo.Rectangle();
					temp.setSize(tile_width*MAP_BLOCK_SIZE, MAP_BLOCK_SIZE/2);
					//print("Meet Ground End");
					local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
					temp.move(temp_coord.x, temp_coord.y + MAP_BLOCK_SIZE/2);
					return temp;
				} else return null;
			}
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[50] = {
		name = "Single 16-Width Align-Left Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[51] = {
		name = "Single 16-Width Align-Right Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[52] = {
		name = "Single 16-Height Align-Top Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[53] = {
		name = "Single 16-Height Align-Bottom Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y + MAP_BLOCK_SIZE/2);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[66] = {
		name = "Single 16X16 Top-Left Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[67] = {
		name = "Single 16X16 Top-Right Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[68] = {
		name = "Single 16X16 Bottom-Left Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y + MAP_BLOCK_SIZE/2);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[69] = {
		name = "Single 16X16 Bottom-Right Ground"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = GROUND_DENSITY,
		fixturedef_friction = GROUND_FRICTION,
		fixturedef_restitution = GROUND_RESTITUTION,
		bodydef_fixrotation = GROUND_FIXROTATION,
		bodydef_lineardamping = GROUND_LINEARDAMPING,
		bodydef_allowsleep = GROUND_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y + MAP_BLOCK_SIZE/2);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			INTERACT_TILE.GROUND_ONIMPACT(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse);
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[9] = {
		name = "Single Wall"
		sprite_create_method = "rectangle",
		rectangle_size = [MAP_BLOCK_SIZE, MAP_BLOCK_SIZE],
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[6] = {
		name = "Continuous 32-Width Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local tile_height = 1;
			for(local j = tile_coord.y + 1;;j++) {
				if(map.getTileAt(j, tile_coord.x) == 22)
					tile_height++;
				else if(map.getTileAt(j, tile_coord.x) == 38) {
					tile_height++;
					local temp = emo.Rectangle();
					temp.setSize(MAP_BLOCK_SIZE, tile_height*MAP_BLOCK_SIZE);
					//print("Meet Ground End");
					local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
					temp.move(temp_coord.x, temp_coord.y);
					return temp;
				} else return null;
			}
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[7] = {
		name = "Continuous 16-Width Align-Left Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local tile_height = 1;
			for(local j = tile_coord.y + 1;;j++) {
				if(map.getTileAt(j, tile_coord.x) == 23)
					tile_height++;
				else if(map.getTileAt(j, tile_coord.x) == 39) {
					tile_height++;
					local temp = emo.Rectangle();
					temp.setSize(MAP_BLOCK_SIZE/2, tile_height*MAP_BLOCK_SIZE);
					//print("Meet Ground End");
					local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
					temp.move(temp_coord.x, temp_coord.y);
					return temp;
				} else return null;
			}
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[8] = {
		name = "Continuous 16-Height Align-Right Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local tile_height = 1;
			for(local j = tile_coord.y + 1;;j++) {
				if(map.getTileAt(j, tile_coord.x) == 24)
					tile_height++;
				else if(map.getTileAt(j, tile_coord.x) == 40) {
					tile_height++;
					local temp = emo.Rectangle();
					temp.setSize(MAP_BLOCK_SIZE/2, tile_height*MAP_BLOCK_SIZE);
					//print("Meet Ground End");
					local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
					temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y);
					return temp;
				} else return null;
			}
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[54] = {
		name = "Single 16-Width Align-Left Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[55] = {
		name = "Single 16-Width Align-Right Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[56] = {
		name = "Single 16-Height Align-Top Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[57] = {
		name = "Single 16-Height Align-Bottom Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y + MAP_BLOCK_SIZE/2);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[70] = {
		name = "Single 16-Width Align-Left Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[71] = {
		name = "Single 16-Width Align-Right Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[72] = {
		name = "Single 16-Height Align-Top Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x, temp_coord.y + MAP_BLOCK_SIZE/2);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	},
	[73] = {
		name = "Single 16-Height Align-Bottom Wall"
		sprite_create_method = "self_construct",
		using_physics = true,
		physics_create_method = "static",
		fixturedef_density = WALL_DENSITY,
		fixturedef_friction = WALL_FRICTION,
		fixturedef_restitution = WALL_RESTITUTION,
		bodydef_fixrotation = WALL_FIXROTATION,
		bodydef_lineardamping = WALL_LINEARDAMPING,
		bodydef_allowsleep = WALL_ALLOWSLEEP,
		constructor(map, tile_coord) {
			local temp = emo.Rectangle();
			temp.setSize(MAP_BLOCK_SIZE/2, MAP_BLOCK_SIZE/2);
			local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
			temp.move(temp_coord.x + MAP_BLOCK_SIZE/2, temp_coord.y + MAP_BLOCK_SIZE/2);
			return temp;
		}
		function onCreate(map, tile_coord) {
		}
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		},
		function onContact(state, fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
		}
	}
}