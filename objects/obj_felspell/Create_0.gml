event_inherited();

audio_play_sound(lp_roberto_base, 0, true)
audio_sound_gain(lp_roberto_base, 0, 0)
visible = false;
owner = noone;
scale = .5;
max_scale = 1;
image_xscale = scale;
image_yscale = scale;
duration = time_bpm_to_seconds(155);
radius = 35;
name = "felspell base";

TweenFire(id, EaseLinear, TWEEN_MODE_PATROL, true, 0.0, duration,
	"scale", scale, max_scale);

function activate(_owner) {
	owner = _owner;
	audio_sound_gain(lp_roberto_base, 1, 1000);
	visible = true;
}