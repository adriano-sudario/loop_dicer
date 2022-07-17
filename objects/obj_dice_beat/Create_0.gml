event_inherited();
description = "beat dice";
type = "beat";

function get_rolled_result() {
	var _index = 0;
	
	if (value > 3)
		_index = 1;
	
	return {
		option: obj_gameplay.dice_options.beat,
		index: _index,
	}
}