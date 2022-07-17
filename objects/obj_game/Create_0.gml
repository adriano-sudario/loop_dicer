#macro RESOLUTION_WIDTH 683
#macro RESOLUTION_HEIGHT 384

display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);

function toggle_fullscreen() {
	window_set_fullscreen(!window_get_fullscreen());
}