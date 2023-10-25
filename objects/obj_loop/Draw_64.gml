if (manager == noone || (!manager.is_active && !manager.is_paused))
	return;

draw_set_colour(text_color);
draw_set_halign(fa_center);

var _current_position = manager.GetCurrentPosition();
var _position_x = room_width - 50;
var _position_y = 15;

draw_text(_position_x, _position_y, string(manager.bpm) + "bpm");

draw_set_colour(circle_color);

var _beat_circle_x = _position_x;
var _beat_circle_y = 50;
var _max_radius = 10;
var _current_radius_percent = frac(_current_position / manager.interval_duration);
var _radius = _max_radius * _current_radius_percent;

draw_circle(_beat_circle_x, _beat_circle_y, _radius, false);