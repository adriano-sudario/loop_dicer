sound_id = audio_play_sound(lp_beat_phantom, 0, true);
audio_sound_gain(lp_beat_phantom, 0, 0);
visible = false;
owner = noone;
duration = time_bpm_to_seconds(155) * 4;
name = "phantom beat";

function spawn() {
	if (owner == noone || obj_gameplay.is_chosing_dice)
		return;
	
	instance_create_layer(owner.x, owner.y, layer, obj_phantom);
}

function activate(_owner) {
	owner = _owner;
	visible = true;
	audio_sound_gain(lp_beat_phantom, 1, 1000);
}

spawn();
wait_for_seconds(duration, spawn, true);