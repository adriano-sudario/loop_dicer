event_inherited();

name = "nebula beat";
sample = new LoopManagerSample("lp_beat_nebula.wav");

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	with (instance_create_layer(owner.x, owner.y, layer, obj_nebula)) {
		speed = 4;
		direction = random_range(0, 360);
	}
}

function on_beat_end(_loop) {
	if (_loop.current_compass_beat % 2 == 0)
		spawn();
}