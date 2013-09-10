OBJECT_COMMON <- {
	WOODEN_BOARD = {
		name = "Wooden Board",
		sprite_create_method = "sprite",
		sprite_rawname = "Item_Wood_Stage.png",
		using_physics = true,
		physics_create_method = "dynamic",
		fixturedef_density = 5,
		fixturedef_friction = 1,
		fixturedef_restitution = 0,
		bodydef_fixrotation = false,
		bodydef_lineardamping = 0,
		bodydef_allowsleep = true,
		function onCreate(coord) {
		},
		function onUpTime(this_sprite) {
		},
		function onImpact(fixtureA, fixtureB, position, normal, normalImpulse, tangentImpulse) {
			if(fixtureA.id == bear.getFixture().id || fixtureB.id == bear.getFixture().id)
				bear.setPhysicsStatus(BEAR_PHYSICS_STATUS.CONTACTED);//if(normal.y == -1) 
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
	}
}