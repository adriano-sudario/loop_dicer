if (!can_move || is_dead || obj_gameplay.is_chosing_dice)
	return;

var x_force = (keyboard_check(ord("D")) || keyboard_check(vk_right))
	- (keyboard_check(ord("A")) || keyboard_check(vk_left));
var y_force = (keyboard_check(ord("S")) || keyboard_check(vk_down))
	- (keyboard_check(ord("W")) || keyboard_check(vk_up));

x = clamp(x + (x_force * walk_speed), bbox_horizontal_center, room_width - bbox_horizontal_center);
y = clamp(y + (y_force * walk_speed), bbox_vertical_center, room_height - bbox_vertical_center);

if (x_force != 0 || y_force != 0) {
	sprite_index = spr_player_walk;
	aiming_at = { x: x_force, y: y_force };
} else {
	sprite_index = spr_player_idle;
}

if (x_force < 0)
	image_xscale = -1;
else if (x_force > 0)
	image_xscale = 1;