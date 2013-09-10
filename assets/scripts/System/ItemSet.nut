emo.Runtime.import(ITEMINFO_PATH + "ItemIce.nut");

class Item extends SpriteButton {
	item_info = null;
	deployable = null;
	
	down_item_coord = null;
	constructor(_iteminfo) {
		item_info = _iteminfo;
		deployable = false;

		base.constructor(item_info.rawname);
	}
	function getItemInfo() {
		return item_info;
	}
	function getItemId() {
		return item_info.id;
	}
	function getItemName() {
		return item_info.name;
	}
	function setDeployable(_bool) {
		deployable = _bool;
	}
	function onMenu(this) {
		item_info.onMenu();
	}
	function onStage() {
		item_info.onStage(this);
	}
	function onDeply() {
		if(deployable) onDeply(this);
	}
	function onPress(mevent) {
		//print("SpriteButton::onPress()");
		this.alpha(0.5);
		
		ui.getItemMenu().setHoldingItem(this);
		down_item_coord = emo.Vec2(this.getX(), this.getY());
	}
	function onRelease(mevent) {
		//print("SpriteButton::onRelease()");
		this.alpha(1);
		
		if(down_item_coord != null) {
			this.move(down_item_coord.x, down_item_coord.y);
			down_item_coord = null;
		}
	}
	function onLongPress(mevent) {
		//print("SpriteButton::onLongPress()");
	}
	function onSelect(mevent) {
		//print("SpriteButton::onSelect()");
	}
	function onMove(mevent) {
		//print("SpriteButton::onMove()");
		//this.alpha(0.5);
	}
}

function createItem(ItemInfo) {
	return Item(ItemInfo);
}
