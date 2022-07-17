if (is_dead)
	return;

if (obj_player.is_dead || obj_gameplay.is_chosing_dice) {
	sprite_index = spr_slime_idle;
	stop();
}

if (can_move)
	chase_player();