if (is_dead || sprite_index == spr_slime_attack || other.is_dead)
	return;

sprite_index = spr_slime_attack;
stop();
other.take_damage(damage);