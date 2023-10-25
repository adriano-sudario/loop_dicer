event_inherited();

name = "phantom beat";
sample = new LoopManagerSample("lp_beat_phantom.wav");

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	instance_create_layer(owner.x, owner.y, layer, obj_phantom);
}

function on_compass_end(_loop) {
	spawn();
}