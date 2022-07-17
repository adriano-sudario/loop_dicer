sound_id = audio_play_sound(lp_bass_f1, 0, true);
audio_sound_gain(lp_bass_f1, 0, 0);
visible = false;
owner = noone;
duration = time_bpm_to_seconds(155) * 4;
name = "f1 bass";

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	with (instance_create_layer(owner.x, owner.y, layer, obj_sunburn)) {
		hspeed = random_range(-1, 1) * 3;
		vspeed = random_range(-1, 1) * 3;
	}
}

function activate(_owner) {
	owner = _owner;
	visible = true;
	audio_sound_gain(lp_bass_f1, 1, 1000);
}

spawn();
wait_for_seconds(duration, spawn, true);