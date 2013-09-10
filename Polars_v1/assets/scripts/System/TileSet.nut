emo.Runtime.import(TILEINFO_PATH + "Interact.nut");

function getTileInfo(chipname, tile_id) {
	switch(chipname) {
		case INTERACT_TILE.CHIPNAME:
			if(INTERACT_TILE.rawin(tile_id))
				return INTERACT_TILE[tile_id];
			else return null;
		break;
		default:
			return null;
		break;
	}
}

function createTile(chipname, map, tile_coord) {
	local tileinfo = getTileInfo(chipname, map.getTileAt(tile_coord.y, tile_coord.x));
	if(tileinfo != null) return createTileObject(tileinfo, map, tile_coord);
	else return null;
}

function createTileObject(TileInfo, map, tile_coord) {
	local temp = null;
	switch(TileInfo.sprite_create_method) {
		case "skinsprite":
			local newSkinSprite = createTileObject(TileInfo.skinsprite, map, tile_coord);
			local newRealSprite = createTileObject(TileInfo.realsprite, map, tile_coord);
			temp = SkinObject(TileInfo, newRealSprite, newSkinSprite);
		break;
		case "sprite":
			temp = emo.Sprite(TileInfo.sprite_rawname);
		break;
		case "rectangle":
			temp = emo.Rectangle();
			temp.setSize(TileInfo.rectangle_size[0], TileInfo.rectangle_size[1]);
			//print("emo.Rectangle()");
		break;
		case "self_construct":
			temp = TileInfo.constructor(map, tile_coord);
		break;
	}
	if(TileInfo.sprite_create_method != "self_construct") {
		TileInfo.onCreate(map, tile_coord);
		local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
		temp.move(temp_coord.x, temp_coord.y);
	}
	if(TileInfo.sprite_create_method != "skinsprite" && 
							temp != null && TileInfo.using_physics) {
		local temp_fixtureDef = emo.physics.FixtureDef();
		local temp_bodyDef = emo.physics.BodyDef();
		temp_fixtureDef.density = TileInfo.fixturedef_density;
		temp_fixtureDef.friction = TileInfo.fixturedef_friction;
		temp_fixtureDef.restitution = TileInfo.fixturedef_restitution;
		temp_bodyDef.fixedRotation = TileInfo.bodydef_fixrotation;
		temp_bodyDef.linearDamping = TileInfo.bodydef_lineardamping;
		temp_bodyDef.allowSleep = TileInfo.bodydef_allowsleep;
		switch(TileInfo.physics_create_method) {
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