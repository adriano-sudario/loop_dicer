if (chosen_instance != noone)
	return;

rolling_counts++;

if (rolling_counts >= max_rolling_counts) {
	value = irandom_range(1, 6);
	var _result = get_rolled_result();
	var _option = _result.option;
	var _option_data = _option[_result.index];
	chosen_instance = instance_create_layer(0, 0, _option_data.layer_name, _option_data.object);
	chosen_instance.activate(instance_find(obj_player, 0));
	
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
}