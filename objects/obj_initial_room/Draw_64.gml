prepare_text_draw(font_big, fa_center, fa_center);
draw_outlined_text(RESOLUTION_WIDTH * .5, 75, "LOOP DICER", make_color_rgb(69, 27, 106));

if (show_begin_text) {
	prepare_text_draw(font, fa_center, fa_center);
	draw_outlined_text(RESOLUTION_WIDTH * .5, RESOLUTION_HEIGHT * .5, "press enter or space to begin");
}

prepare_text_draw(fnt_mono_super_small, fa_left, fa_center);

draw_set_colour(c_red);
draw_text(15, RESOLUTION_HEIGHT - 120, "programming and game design: adriano sudario");
draw_text(15, RESOLUTION_HEIGHT - 105, "sounds: jose paula");

draw_set_colour(make_color_rgb(41, 24, 90));
draw_text(15, RESOLUTION_HEIGHT - 75, "background by liz wilson (behance)");
draw_text(15, RESOLUTION_HEIGHT - 60, "characters assets by game endeavor (itch)");
draw_text(15, RESOLUTION_HEIGHT - 45, "vfx's assets by codemanu (itch)");
draw_text(15, RESOLUTION_HEIGHT - 30, "explosion vfx's assets by ansimuz (itch)");
draw_text(15, RESOLUTION_HEIGHT - 15, "monogram font by datagoblin (itch)");