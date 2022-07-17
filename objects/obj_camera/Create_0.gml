camera = view_camera[0];
following = obj_player;
viewport = {
	half_width: camera_get_view_width(camera) * .5,
	half_height: camera_get_view_height(camera) * .5
};
buff = 0;
shake = noone;

if (!instance_exists(following))
	return;

x = clamp(following.x, viewport.half_width, room_width - viewport.half_width);
y = clamp(following.y, viewport.half_height, room_height - viewport.half_height);