enum OBJECT_STATE {
	NOTHING,
	PREVIEWING,
	COMBINED
}

class SkinObject {
	object_info = null;
	
	realsprite = null;
	skinsprite = null;
	state = null;
	custom_state = null;
	
	combined = false;
	
	constructor(_object_info, _realsprite, _skinsprite = null) {
		object_info = _object_info;
		
		realsprite = _realsprite;
		if(_skinsprite != null) addSkinSprite(_skinsprite);
		state = OBJECT_STATE.NOTHING;
		combined = false;
	}
	function load() {
		if(realsprite != null) realsprite.load();
		if(skinsprite != null) skinsprite.load();
	}
	function remove() {
		if(realsprite != null) {
			realsprite.remove();
			realsprite = null;
		}
		if(skinsprite != null) {
			skinsprite.remove();
			skinsprite = null;
		}
	}
	function show() {
		if(realsprite != null && realsprite.alpha() > 0) realsprite.show();
		if(skinsprite != null) skinsprite.show();
	}
	function hide() {
		if(realsprite != null && realsprite.alpha() > 0) realsprite.hide();
		if(skinsprite != null) skinsprite.hide();
	}
	function collidesWith(sprite) {
		if(realsprite != null && realsprite.alpha() > 0) return realsprite.collidesWith(sprite);
		else if(skinsprite != null) return skinsprite.collidesWith(sprite);
	}
	function getObjectInfo() {
		return object_info;
	}
	function getX() {
		return realsprite.getX();
	}
	function getY() {
		return realsprite.getY();
	}
	function getWidth() {
		return realsprite.getWidth();
	}
	function getHeight() {
		return realsprite.getHeight();
	}
	function move(_x, _y) {
		realsprite.move(_x, _y);
		if(skinsprite != null) {
			local skin_x = 0;
			local skin_y = 0;
			
			switch(object_info.align_x) {
				case HORIZONTAL_ALIGH.LEFT:
					skin_x = this.getX();
				break;
				case HORIZONTAL_ALIGH.CENTER:
					skin_x = this.getX() + (this.getWidth() - skinsprite.getWidth())/2;
				break;
				case HORIZONTAL_ALIGH.RIGHT:
					skin_x = this.getX() + this.getWidth() - skinsprite.getWidth();
				break;
			}
			switch(object_info.align_y) {
				case VERTICAL_ALIGH.TOP:
					skin_y = this.getY();
				break;
				case VERTICAL_ALIGH.CENTER:
					skin_y = this.getY() + (this.getHeight() - skinsprite.getHeight())/2;
				break;
				case VERTICAL_ALIGH.BOTTOM:
					skin_y = this.getY() + this.getHeight() - skinsprite.getHeight();
				break;
			}
			skinsprite.move(skin_x, skin_y);
		}
	}
	function color(_r, _g, _b, _a = null) {
		if(realsprite != null && realsprite.alpha() > 0) realsprite.color(_r, _g, _b, _a);
		if(skinsprite != null) skinsprite.color(_r, _g, _b, _a);
	}
	function setZ(_z) {
		if(realsprite != null) realsprite.setZ(_z - 2);
		if(skinsprite != null) skinsprite.setZ(_z - 1);
	}
	function getZ() {
		return realsprite.getZ();
	}
	function getObjectInfo() {
		return object_info;
	}
	function getRealSprite() {
		return realsprite;
	}
	function addSkinSprite(_sprite) {
		skinsprite = _sprite;
		skinsprite.setZ(this.getZ() - 1);
		skinsprite.load();
		realsprite.hide();
	}
	function removeSkinSprite() {
		if(skinsprite != null) {
			skinsprite.remove();
			skinsprite = null;
		}
	}
	function changeSkinSprite(_sprite) {
		if(skinsprite != null) {
			_sprite.move(skinsprite.getX(), skinsprite.getY());
			_sprite.setZ(skinsprite.getZ());
			if(skinsprite.isLoaded()) _sprite.load();
			
			skinsprite.remove();
			skinsprite = null;
		}
		skinsprite = _sprite;
	}
	function changeRealSprite(_sprite) {
		if(realsprite != null) {
			_sprite.move(realsprite.getX(), realsprite.getY());
			_sprite.setZ(realsprite.getZ());
			if(realsprite.isLoaded()) _sprite.load();
			
			realsprite.remove();
			realsprite = null;
		}
		realsprite = _sprite;
	}
	function getSkinSprite() {
		return skinsprite;
	}
	function getPhysicsInfo() {
		return realsprite.getPhysicsInfo();
	}
	function setState(_state) {
		state = _state;
	}
	function getState() {
		return state;
	}
	function setCustomState(_custom_state) {
		custom_state = _custom_state;
	}
	function getCustomState() {
		return custom_state;
	}
	function isLoaded() {
		return realsprite.isLoaded();
	}
	function getFixture() {
		return realsprite.getFixture();
	}
	/*function onUpTime() {
		if(skinsprite != null) skinsprite.move(this.getX(), this.getY());
		
		object_info.onUpTime(this);
	}*/
	function onPreview() {
		object_info.onPreview(this);
		state = OBJECT_STATE.PREVIEWING;
	}
	function onCancel() {
		object_info.onCancel(this);
		if(combined) state = OBJECT_STATE.COMBINED;
		else state = OBJECT_STATE.NOTHING;
	}
	function onCombine() {
		object_info.onCombine(this);
		state = OBJECT_STATE.COMBINED;
		combined = true;
	}
}