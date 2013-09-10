ITEM_COMMON <- {
	WOODEN_BOARD = {
		id = 0,
		name = "Wooden Board",
		menu_rawname = "Item_Wood_Menu.png",
		stage_rawname = "Item_Wood_Stage.png",
		objectinfo = OBJECT_COMMON.WOODEN_BOARD,
		function onMenu(item) {
			print("WOODEN_BOARD::onMenu");
			local newObject = emo.Sprite(menu_rawname);
			item.applySettings(newObject);
			item.changeObject(newObject);
			
			item.setDeployable(false);
		},
		function onStage(item) {
			print("WOODEN_BOARD::onStage");
			local newObject = emo.Sprite(stage_rawname);
			item.applySettings(newObject);
			newObject.alpha(0.5);
			item.changeObject(newObject);
			
			item.setDeployable(true);
		},
		function onDeploy(item) {
			print("WOODEN_BOARD::onDeploy");
			local coord = emo.Vec2(item.getX() + Camera_X, item.getY() + Camera_Y);
			local newObject = createObjectByCoord(objectinfo, coord);
			local objeclayer = layermanager.getLayer(OBJECT_LAYER_NUM);
			objeclayer.getObjectManager().addObject(newObject, objectinfo);
			objeclayer.applySettings(newObject);
			newObject.alpha(1);
			
			ui.getItemMenu().removeItem(item);
		}
	},
	ROPE = {
		id = 1,
		name = "Rope",
		menu_rawname = "Item_Rope_Menu.png",
		function onMenu(item) {
			print("ROPE::onMenu");
			
			item.setDeployable(false);
		},
		function onStage(item) {
			print("ROPE::onStage");
			local object = item.getObject();
			object.alpha(0.5);
		},
		function onDeploy(item) {
			print("ROPE::onDeploy");
			
			ui.getItemMenu().removeItem(item);
		}
	}
}