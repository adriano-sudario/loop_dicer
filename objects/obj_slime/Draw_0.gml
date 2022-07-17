if (is_blinking && blinks_count % 2 != 0) {
	shader_set(sh_fill_white);
	draw_self();
	shader_reset();
} else {
	draw_self();
}