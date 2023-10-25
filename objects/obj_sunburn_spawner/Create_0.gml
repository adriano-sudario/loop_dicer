event_inherited();

name = "f1 bass";
sample = new LoopManagerSample("lp_bass_f1.wav");

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	with (instance_create_layer(owner.x, owner.y, layer, obj_sunburn)) {
		hspeed = random_range(-1, 1) * 3;
		vspeed = random_range(-1, 1) * 3;
	}
}

function on_compass_end(_loop) {
	spawn();
}