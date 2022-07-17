if (is_rolling) 
	return;

if (is_selected && !is_rolling) {
	image_index = 0;
	image_xscale = DICE_HUD_SCALE + 1;
	image_yscale = DICE_HUD_SCALE + 1;
	image_blend = make_colour_rgb(217, 87, 99);
} else {
	image_index = 1;
	image_xscale = DICE_HUD_SCALE;
	image_yscale = DICE_HUD_SCALE;
	image_blend = c_white;
}