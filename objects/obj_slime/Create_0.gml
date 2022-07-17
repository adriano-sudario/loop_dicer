enum DamageType { Blink, Animation }

walking_speed = random_range(.6, 1.2);
hp = random_range(1, 5);
damage = random_range(1, 2);
can_move = true;
is_dead = false;
is_blinking = false;
blinks_count = 0;
max_blinks_count = 4;

function blink() {
	is_blinking = true;
	blinks_count++;
	
	if (blinks_count >= max_blinks_count) {
		is_blinking = false;
		blinks_count = 0;
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

function chase_player() {
	if (is_dead)
		return;
	
	move_towards_point(obj_player.x, obj_player.y, walking_speed);
}

function move() {
	if (is_dead)
		return;
	
	can_move = true;
	chase_player();
	sprite_index = spr_slime_walk;
}

function stop() {
	speed = 0;
	can_move = false;
}

function die() {
	if (is_dead)
		return;
	
	stop();
	sprite_index = spr_slime_death;
	obj_gameplay.slimes_killed_count++;
	is_dead = true;
	obj_player.earn_xp();
}

function take_damage(_amount, _type = DamageType.Animation) {
	if (is_dead)
		return;
	
	hp -= _amount;
	
	if (hp <= 0) {
		die();
		return;
	}
	
	if (_type == DamageType.Animation) {
		image_index = 0;
		sprite_index = spr_slime_damaged;
		stop();
	} else if (!is_blinking) {
		blink();
	}
}

move();