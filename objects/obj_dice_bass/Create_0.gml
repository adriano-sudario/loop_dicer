event_inherited();
description = "bass dice";
type = "bass";

function get_rolled_result() {
	var _index = 0;
	
	if (value > 3)
		_index = 1;
	
	return {
		option: obj_gameplay.dice_options.bass,
		index: _index,
	}
}