/// @function tweening_custom(mode, modifier_name, target_value, duration, optional_params);
/// @param {mode} tweening mode
/// @param {modifier_name} tweening modifier name
/// @param {target_value} tweening target
/// @param {duration} tweening duration
/// @param {optional_params} optional parameters

function tweening_custom(_mode, _modifier_name, _target_value, _duration, _optional_params = noone) {
	var start_on_create = true;
	
	if (_optional_params != noone && variable_struct_exists(_optional_params, "start_on_create"))
		start_on_create = _optional_params.start_on_create;
	
	if (_optional_params == noone)
		_optional_params =  { start_on_create: false };
	else if (!variable_struct_exists(_optional_params, "start_on_create"))
		variable_struct_set(_optional_params, "start_on_create", false);
	else
		_optional_params.start_on_create = false;
	
	var tween = tweening(_mode, TWEEN_MODIFIER.CUSTOM, _target_value, _duration, _optional_params);
	tween.modifier_name = _modifier_name;
	
	tween.set_initial_value();
	
	if (start_on_create)
		tween.start();
	else
		tween.pause();
	
	return tween;
}