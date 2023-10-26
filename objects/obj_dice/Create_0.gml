#macro DICE_HUD_SCALE 3

image_speed = 0;
image_index = 1;
image_xscale = DICE_HUD_SCALE;
image_yscale = DICE_HUD_SCALE;
is_selected = false;
description = "";
font = fnt_mono_small;
font_small = fnt_mono_smallest;
is_rolling = false;
rolling_counts = 0;
max_rolling_counts = 1;
value = 0;
type = "";
chosen_instance = noone;

function roll() {
	max_rolling_counts = irandom_range(2, 5);
	is_rolling = true;
	image_index = 0;
	image_speed = 1;
	image_xscale = DICE_HUD_SCALE;
	image_yscale = DICE_HUD_SCALE;
	image_blend = c_white;
}

function stop_roll() {
	image_speed = 0;
	sprite_index = spr_dice_results;
	image_index = value - 1;
	is_rolling = false;
	var _close = function() { obj_dice_chosing_hud.close(); }
	var _duration = time_bpm_to_seconds(BPM) * 4;
	var _time_source = time_source_create(time_source_game, _duration, time_source_units_seconds, _close);
	time_source_start(_time_source);
}

function get_rolled_result() {
	
}