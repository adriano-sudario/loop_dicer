event_inherited();

audio_play_sound(lp_base_felspell, 0, true)
audio_sound_gain(lp_base_felspell, 0, 0)
visible = false;
owner = noone;
scale = .5;
max_scale = 1;
image_xscale = scale;
image_yscale = scale;
duration = time_bpm_to_seconds(155);
radius = 35;
name = "felspell base";

tweening_custom(TWEEN_MODE.YOYO, "scale", max_scale, duration, 
	{
		ease_function: linear,
	});

function activate(_owner) {
	owner = _owner;
	audio_sound_gain(lp_base_felspell, 1, 1000);
	visible = true;
}