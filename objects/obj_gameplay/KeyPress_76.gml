if (debug_mode && keyboard_check(vk_control)) {
	obj_player.xp = obj_player.xp_to_next_level;
	obj_player.earn_xp();
}