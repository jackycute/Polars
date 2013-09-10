class Event {
	enable = false;
	function load() {
		enable = true;
	}
	function remove() {
		enable = false;
		return null;
	}
	function onUpTime(this_event) {
		print("Event::onUpTime");
	}
}

function createEventBlockByMap(map, tile_coord) {
	local temp = null;
	temp = emo.Rectangle();
	temp.setSize(MAP_BLOCK_SIZE, MAP_BLOCK_SIZE);
	local temp_coord = map.getTileCoordAtIndex(tile_coord.x, tile_coord.y);
	temp.move(temp_coord.x, temp_coord.y);
	return temp;
}