if (chosen_instance != noone)
	return;

rolling_counts++;

if (rolling_counts >= max_rolling_counts) {
	image_speed = 0;
	sprite_index = spr_dice_results;
	value = irandom_range(1, 6);
	image_index = value - 1;
	var _result = get_rolled_result();
	var _option = _result.option;
	chosen_instance = _option[_result.index];
	chosen_instance.activate(instance_find(obj_player, 0));
	is_rolling = false;
	
	for (var i = 0; i < array_length(_option); i++) {
		if (_option[i].id != chosen_instance.id)
			instance_destroy(_option[i]);
	}
	
	switch (type) {
		case "ambience":
			obj_gameplay.owned_loops.ambience = chosen_instance;
			break;
		
		case "base":
			obj_gameplay.owned_loops.base = chosen_instance;
			break;
		
		case "bass":
			obj_gameplay.owned_loops.bass = chosen_instance;
			break;
		
		case "beat":
			obj_gameplay.owned_loops.beat = chosen_instance;
			break;
	}
	
	var _close = function() {
		obj_dice_chosing_hud.close();
	}

	var _time_source = time_source_create(
		time_source_game, 1, time_source_units_seconds, _close);

	time_source_start(_time_source);
}