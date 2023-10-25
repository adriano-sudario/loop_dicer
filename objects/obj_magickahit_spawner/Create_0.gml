event_inherited();

name = "magickahit ambience";
sample = new LoopManagerSample("lp_ambience_magickahit.wav");

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	var _magickahit = instance_create_layer(owner.x, owner.y, layer, obj_magickahit);
	_magickahit.owner = owner;
}

function on_compass_end(_loop) {
	spawn();
}