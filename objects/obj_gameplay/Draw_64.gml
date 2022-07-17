if (obj_player.is_dead) {
	prepare_text_draw(font, fa_center, fa_center);
	draw_outlined_text(RESOLUTION_WIDTH * .5, RESOLUTION_HEIGHT * .5,
		"you died. press enter or space to restart.");
	
	prepare_text_draw(font_small, fa_center, fa_center);
	draw_outlined_text(RESOLUTION_WIDTH * .5, 10, string(slimes_killed_count) + " slimes killed");
	return;
}

if (is_chosing_dice)
	return;
	
prepare_text_draw(font_small, fa_center, fa_center);
draw_outlined_text(RESOLUTION_WIDTH * .5, 10, string(slimes_killed_count) + " slimes killed");

var _hp_bar_width = 500;
var _hp_bar_height = 10;
var _hp_bar_x = (RESOLUTION_WIDTH * .5) - (_hp_bar_width * .5);
var _hp_bar_y = 20;

draw_set_colour(c_grey);
draw_rectangle(_hp_bar_x, _hp_bar_y, _hp_bar_x + _hp_bar_width, _hp_bar_y + _hp_bar_height, false);
	
if (obj_player.xp == 0)
	return;

draw_set_colour(c_blue);
draw_rectangle(_hp_bar_x, _hp_bar_y,
		_hp_bar_x + floor((_hp_bar_width * (obj_player.xp / obj_player.xp_to_next_level))),
		_hp_bar_y + _hp_bar_height,
		false);