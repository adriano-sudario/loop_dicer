event_inherited();

audio_play_sound(lp_roberto_ambience, 0, true)
audio_sound_gain(lp_roberto_ambience, 0, 0)
visible = false;
owner = noone;
scale = 1.5;
image_xscale = scale;
image_yscale = scale * 2;
duration = time_bpm_to_seconds(155) * 4;
name = "brightfire ambience";

function change() {
	if (owner == noone)
		return;
	
	image_angle = random_range(0, 360);
}

change();
wait_for_seconds(duration, change, true);

function activate(_owner) {
	owner = _owner;
	audio_sound_gain(lp_roberto_ambience, 1, 1000);
	visible = true;
}