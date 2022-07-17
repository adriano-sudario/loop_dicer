draw_self();

if (is_rolling)
	return;

var _padding_bottom = 15;

if (chosen_instance != noone) {
	prepare_text_draw(font, fa_center, fa_center);
	draw_outlined_text(x, bbox_bottom + _padding_bottom, chosen_instance.name, c_red);
} else if (is_selected) {
	prepare_text_draw(font, fa_center, fa_center);
	draw_outlined_text(x, bbox_bottom + _padding_bottom, description, c_red);
} else {
	prepare_text_draw(font_small, fa_center, fa_center);
	draw_outlined_text(x, bbox_bottom + _padding_bottom, description);
}