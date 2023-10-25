event_inherited();

scale = .5;
image_xscale = scale;
image_yscale = scale;
name = "vortex ambience";
sample = new LoopManagerSample("lp_base_vortex.wav");

function change() {
	if (owner == noone)
		return;
	
	var _camera = obj_camera.camera;
	var _view_width = camera_get_view_width(_camera);
	var _view_height = camera_get_view_height(_camera);
	var _view_x = camera_get_view_x(_camera);
	var _view_y = camera_get_view_y(_camera);
	
	x = random_range(_view_x + 50, _view_x + _view_width - 50);
	y = random_range(_view_y + 50, _view_y + _view_height - 50);
}

function on_compass_end(_loop) {
	change();
}