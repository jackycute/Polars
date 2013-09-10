emo.Runtime.import(OBJECTINFO_PATH + "ObjectCommon.nut");
emo.Runtime.import(OBJECTINFO_PATH + "ObjectIce.nut");

function getObjectInfo(chipname, tile_id) {
	switch(chipname) {
		case OBJECT_ICE.CHIPNAME:
			if(OBJECT_ICE.rawin(tile_id))
				return OBJECT_ICE[tile_id];
			else return null;
		break;
		default:
			return null;
		break;
	}
}

function createObjectByMap(chipname, map, tile_coord) {
	local tileinfo = getObjectInfo(chipname, map.getTileAt(tile_coord.y, tile_coord.x));
	if(tileinfo != null) return createObject(tileinfo, map, tile_coord);
	else return null;
}

function createObject(ObjectInfo, map, tile_coord) {
	local temp = null;
	switch(ObjectInfo.sprite_create_method) {
		case "skinsprite":
			local newSkinSprite = createObject(ObjectInfo.skinsprite, map, tile_coord);
			local newRealSprite = createObject(ObjectInfo.realsprite, map, tile_coord);
			temp = SkinObject(ObjectInfo, newRealSprite, newSkinSprite);
		break;
		case "sprite":
			temp = emo.Sprite(ObjectInfo.sprite_rawname);
		break;
		case "rectangle":
			temp = emo.Rectangle();
			temp.setSize(ObjectInfo.rectangle_size[0], ObjectInfo.rectangle_size[1]);
			//print("emo.Rectangle()");
		break;
		case "self_construct":
			temp = ObjectInfo.constructor(map, tile_coord);
		break;
	}
	if(ObjectInfo.sprite_create_method != "self_construct") {
		ObjectInfo.onCreate(map, tile_coord);
		local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
		temp.move(temp_coord.x, temp_coord.y);
	}
	if(ObjectInfo.sprite_create_method != "skinsprite" && 
							temp != null && ObjectInfo.using_physics) {
		local temp_fixtureDef = emo.physics.FixtureDef();
		local temp_bodyDef = emo.physics.BodyDef();
		temp_fixtureDef.density = ObjectInfo.fixturedef_density;
		temp_fixtureDef.friction = ObjectInfo.fixturedef_friction;
		temp_fixtureDef.restitution = ObjectInfo.fixturedef_restitution;
		temp_bodyDef.fixedRotation = ObjectInfo.bodydef_fixrotation;
		temp_bodyDef.linearDamping = ObjectInfo.bodydef_lineardamping;
		temp_bodyDef.allowSleep = ObjectInfo.bodydef_allowsleep;
		switch(ObjectInfo.physics_create_method) {
			case "static":
				physics.createStaticSprite(world, temp, temp_fixtureDef, temp_bodyDef);
				//print("physics.createStaticSprite()");
			break;
			case "dynamic":
				physics.createDynamicSprite(world, temp, temp_fixtureDef, temp_bodyDef);
			break;
		}
	}
	return temp;
}

function createObjectByCoord(ObjectInfo, coord) {
	local temp = null;
	switch(ObjectInfo.sprite_create_method) {
		case "skinsprite":
			local newSkinSprite = createObjectByCoord(ObjectInfo.skinsprite, coord);
			local newRealSprite = createObjectByCoord(ObjectInfo.realsprite, coord);
			temp = SkinObject(ObjectInfo, newRealSprite, newSkinSprite);
		break;
		case "sprite":
			temp = emo.Sprite(ObjectInfo.sprite_rawname);
		break;
		case "rectangle":
			temp = emo.Rectangle();
			temp.setSize(ObjectInfo.rectangle_size[0], ObjectInfo.rectangle_size[1]);
			//print("emo.Rectangle()");
		break;
		case "self_construct":
			temp = ObjectInfo.constructor(coord);
		break;
	}
	if(ObjectInfo.sprite_create_method != "self_construct") {
		ObjectInfo.onCreate(coord);
		temp.move(coord.x, coord.y);
	}
	if(ObjectInfo.sprite_create_method != "skinsprite" && 
							temp != null && ObjectInfo.using_physics) {
		local temp_fixtureDef = emo.physics.FixtureDef();
		local temp_bodyDef = emo.physics.BodyDef();
		temp_fixtureDef.density = ObjectInfo.fixturedef_density;
		temp_fixtureDef.friction = ObjectInfo.fixturedef_friction;
		temp_fixtureDef.restitution = ObjectInfo.fixturedef_restitution;
		temp_bodyDef.fixedRotation = ObjectInfo.bodydef_fixrotation;
		temp_bodyDef.linearDamping = ObjectInfo.bodydef_lineardamping;
		temp_bodyDef.allowSleep = ObjectInfo.bodydef_allowsleep;
		switch(ObjectInfo.physics_create_method) {
			case "static":
				physics.createStaticSprite(world, temp, temp_fixtureDef, temp_bodyDef);
				//print("physics.createStaticSprite()");
			break;
			case "dynamic":
				physics.createDynamicSprite(world, temp, temp_fixtureDef, temp_bodyDef);
			break;
		}
	}
	return temp;
}