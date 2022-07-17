/// @function prepare_text_draw(font, horizontal_align, vertical_align, color)

function prepare_text_draw(_font, _horizontal_align, _vertical_align) {
	draw_set_font(_font);
	draw_set_halign(_horizontal_align);
	draw_set_valign(_vertical_align);
	if (argument_count > 3)
		draw_set_color(argument[3]);
}