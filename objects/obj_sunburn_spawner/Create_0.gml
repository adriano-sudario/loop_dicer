event_inherited();

name = "f1 bass";
sample = new LoopManagerSample("lp_bass_f1.wav");

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	var nearest_slime = instance_nearest(owner.x, owner.y, obj_slime);
	
	if (nearest_slime != noone) {
		with (instance_create_layer(owner.x, owner.y, layer, obj_sunburn)) {
			speed = random_range(.25, 3);
			direction = point_direction(x, y, nearest_slime.x, nearest_slime.y);
			image_angle = direction;
		}
	} else {
		with (instance_create_layer(owner.x, owner.y, layer, obj_sunburn)) {
			hspeed = random_range(-1, 1) * 3;
			vspeed = random_range(-1, 1) * 3;
			
			if (hspeed < .25 && vspeed < .25)
				hspeed = .25;
		}
	}
}

function on_compass_end(_loop) {
	spawn();
}