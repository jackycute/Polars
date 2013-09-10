emo.Runtime.import(ITEMINFO_PATH + "ItemCommon.nut");

class Item extends SpriteButton {
	item_info = null;
	deployable = null;
	deployCallBack = null;
	tag = null;
	
	down_item_coord = null;
	constructor(_item_info) {
		item_info = _item_info;
		deployable = false;

		base.constructor(item_info.menu_rawname);
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
	function setDeployable(_bool, _callback = null) {
		deployable = _bool;
		deployCallBack = _callback;
	}
	function getDeployable() {
		return deployable;
	}
	function setTag(_tag) {
		tag = _tag;
	}
	function getTag() {
		return tag;
	}
	function onMenu() {
		item_info.onMenu(this);
	}
	function onStage() {
		item_info.onStage(this);
	}
	function onDeploy() {
		if(deployable) {
			item_info.onDeploy(this);
			if(deployCallBack != null) deployCallBack.onCombine();
		}
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