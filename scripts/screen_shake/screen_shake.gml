/// @function screen_shake(magnitude, frames)

function screen_shake(_magnitude, _frames){
	with(obj_camera) {
		if (shake != noone && _magnitude <= shake.current_magnitude)
			return;
			
		shake = {
			frames: _frames,
			magnitude: _magnitude,
			current_magnitude: _magnitude
		};
	}
}