/// @function tweening(mode, modifier, target_value, duration, optional_params);
/// @param {mode} tweening mode
/// @param {modifier} tweening modifier
/// @param {target_value} tweening target
/// @param {duration} tweening duration
/// @param {optional_params} optional parameters

function tweening(_mode, _modifier, _target_value, _duration, _optional_params = noone) {
	var tween = instance_create_layer(0, 0, layer, obj_tweening);
	tween.instance = self;
	tween.mode = _mode;
	tween.modifier = _modifier;
	tween.duration = _duration;
	tween.target_value = _target_value;
	
	var start_on_create = true;
	
	if (_optional_params != noone) {
		if (variable_struct_exists(_optional_params, "instance") &&
			_optional_params.instance != noone)
			tween.instance = _optional_params.instance;
		
		if (variable_struct_exists(_optional_params, "ease_function") &&
			_optional_params.ease_function != noone)
			tween.ease_function = _optional_params.ease_function;
		
		if (variable_struct_exists(_optional_params, "step_to_update") &&
			_optional_params.step_to_update != noone)
			tween.step_to_update = _optional_params.step_to_update;
		
		if (variable_struct_exists(_optional_params, "on_finish"))
			tween.on_finish = _optional_params.on_finish;
		
		if (variable_struct_exists(_optional_params, "start_on_create") &&
			_optional_params.start_on_create != noone)
			start_on_create = _optional_params.start_on_create;
	}
	
	if (tween.modifier != TWEEN_MODIFIER.CUSTOM)
		tween.set_initial_value();
	
	if (start_on_create)
		tween.start();
	
	return tween;
}