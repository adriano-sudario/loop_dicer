event_inherited();

velocity = 2;
name = "little syrup bass";
sample = new LoopManagerSample("lp_bass_xaropinho.wav");

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	var xaropinho = instance_create_layer(owner.x, owner.y, layer, obj_xaropinho)
	xaropinho.hspeed = owner.aiming_at.x * velocity;
	xaropinho.vspeed = owner.aiming_at.y * velocity;
	xaropinho.velocity = velocity;
}

function on_compass_end(_loop) {
	spawn();
}