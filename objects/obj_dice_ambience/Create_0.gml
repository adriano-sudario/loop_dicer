event_inherited();
description = "ambience dice";
type = "ambience";

function get_rolled_result() {
	return {
		option: obj_gameplay.dice_options.ambience,
		index: 0,
	}
}