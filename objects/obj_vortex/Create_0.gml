event_inherited();

audio_play_sound(lp_roberto_ambience, 0, true)
audio_sound_gain(lp_roberto_ambience, 0, 0)
visible = false;
owner = noone;
scale = .5;
image_xscale = scale;
image_yscale = scale;
duration = time_bpm_to_seconds(155) * 4;
name = "vortex ambience";

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

change();
wait_for_seconds(duration, change, true);

function activate(_owner) {
	owner = _owner;
	audio_sound_gain(lp_roberto_ambience, 1, 1000);
	visible = true;
}