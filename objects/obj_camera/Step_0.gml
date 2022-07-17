if (instance_exists(following)) {
	x += (following.x - x) / 25;
	y += (following.y - y) / 25;
}

x = clamp(x, viewport.half_width + buff, room_width - viewport.half_width - buff);
y = clamp(y, viewport.half_height, room_height - viewport.half_height);

if (shake != noone) {
	x += random_range(-shake.current_magnitude, shake.current_magnitude);
	y += random_range(-shake.current_magnitude, shake.current_magnitude);
	shake.current_magnitude -= max(0, (1 / shake.frames) * shake.magnitude);
	if (shake.current_magnitude <= 0)
		shake = noone;
}

camera_set_view_pos(camera, x - viewport.half_width, y - viewport.half_height);