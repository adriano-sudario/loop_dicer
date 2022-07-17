duration = time_bpm_to_seconds(155) * 8;

function spawn() {
	if (obj_gameplay.is_chosing_dice)
		return;
	
	var _camera = obj_camera.camera;
	var _view_width = camera_get_view_width(_camera);
	var _view_height = camera_get_view_height(_camera);
	var _view_x = camera_get_view_x(_camera);
	var _view_y = camera_get_view_y(_camera);
	
	var _position = {
		x: random_range(_view_x - 50, _view_x + _view_width + 50),
		y: random_range(_view_y - 50, _view_y + _view_height + 50)
	};
	
	switch (choose("left", "right", "top", "down")) {
		case "left":
			_position.x = _view_x - 50;
			break;
			
		case "right":
			_position.x = _view_x + _view_width + 50;
			break;
			
		case "top":
			_position.y = _view_y - 50;
			break;
			
		case "down":
			_position.y = _view_y + _view_height + 50;
			break;
	}
	
	instance_create_layer(_position.x, _position.y, "Monsters", obj_slime);
}

wait_for_seconds(duration, spawn, true);