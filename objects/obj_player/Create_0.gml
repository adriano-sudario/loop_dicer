var _bbox_width = (bbox_right - bbox_left);
var _bbox_height = (bbox_bottom - bbox_top);
bbox_horizontal_center = _bbox_width * .5;
bbox_vertical_center = _bbox_height * .5;
walk_speed = 1.5;
can_move = true;
is_dead = false;
hp = 7;
is_immune = false;
is_blinking = false;
blinks_count = 0;
max_blinks_count = 4;
aiming_at = { x: 1, y: 0 };
xp = 0;
xp_to_next_level = 20;

function earn_xp() {
	xp += irandom_range(1, 6);
	
	if (xp >= xp_to_next_level
		&& (obj_gameplay.owned_loops.beat == noone
		|| obj_gameplay.owned_loops.base == noone
		|| obj_gameplay.owned_loops.bass == noone
		|| obj_gameplay.owned_loops.ambience == noone)) {
		xp = 0;
		show_dice_chosing_hud();
	}
}

function blink() {
	is_blinking = true;
	is_immune = true;
	blinks_count++;
	
	if (blinks_count >= max_blinks_count) {
		is_blinking = false;
		blinks_count = 0;
		is_immune = false;
		return;
	}
	
	var _on_blink = function(_caller)
	{
		with(_caller)
			blink();
	}

	var _time_source = time_source_create(
		time_source_game, .1, time_source_units_seconds, _on_blink, [self]);

	time_source_start(_time_source);
}

function die() {
	if (is_dead)
		return;
	
	image_index = 0;
	sprite_index = spr_player_death;
	is_dead = true;
	
	with (obj_loop_manager) {
		with (loop) {
			manager.Stop();
			instance_destroy();
		}
		
		loop = noone;
	}
	
	instance_destroy(obj_gameplay.owned_loops.beat);
	instance_destroy(obj_gameplay.owned_loops.base);
	instance_destroy(obj_gameplay.owned_loops.bass);
	instance_destroy(obj_gameplay.owned_loops.ambience);
}

function take_damage(_amount) {
	if (is_immune || is_dead)
		return;
	
	hp -= _amount;
	
	if (hp <= 0)
		die();
	else
		blink();
}