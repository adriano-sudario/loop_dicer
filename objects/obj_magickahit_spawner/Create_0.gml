sound_id = audio_play_sound(lp_roberto_ambience, 0, true);
audio_sound_gain(lp_roberto_ambience, 0, 0);
visible = false;
owner = noone;
duration = time_bpm_to_seconds(155) * 4;
name = "magickahit ambience";

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	var _magickahit = instance_create_layer(owner.x, owner.y, layer, obj_magickahit);
	_magickahit.owner = owner;
}

function activate(_owner) {
	owner = _owner;
	visible = true;
	audio_sound_gain(lp_roberto_ambience, 1, 1000);
}

spawn();
wait_for_seconds(duration, spawn, true);