event_inherited();
description = "base dice";
type = "base";

function get_rolled_result() {
	return {
		option: obj_gameplay.dice_options.base,
		index: 0,
	}
}