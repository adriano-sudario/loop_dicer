sound_id = audio_play_sound(lp_bass_xaropinho, 0, true);
audio_sound_gain(lp_bass_xaropinho, 0, 0);
visible = false;
owner = noone;
duration = time_bpm_to_seconds(155) * 4;
velocity = 2;
name = "little syrup bass";

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	var xaropinho = instance_create_layer(owner.x, owner.y, layer, obj_xaropinho)
	xaropinho.hspeed = owner.aiming_at.x * velocity;
	xaropinho.vspeed = owner.aiming_at.y * velocity;
	xaropinho.velocity = velocity;
}

function activate(_owner) {
	owner = _owner;
	visible = true;
	audio_sound_gain(lp_bass_xaropinho, 1, 1000);
}

spawn();
wait_for_seconds(duration, spawn, true);