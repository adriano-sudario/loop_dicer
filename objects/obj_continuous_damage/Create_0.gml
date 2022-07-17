damage = .5;
ignored_units = [];

function apply_damage(_unit) {
	if (obj_gameplay.is_chosing_dice || !instance_exists(_unit))
		return;
	
	for (var i = 0; i < array_length(ignored_units); i++)
		if (instance_exists(ignored_units[i]) && _unit.id == ignored_units[i].id)
			return;
	
	_unit.take_damage(damage, DamageType.Blink);
	array_push(ignored_units, _unit);

	var remove_from_ignored = function(_self, _other)
	{
		with(_self) {
			for (var i = 0; i < array_length(ignored_units); i++) {
				if (instance_exists(ignored_units[i]) && ignored_units[i].id == _other.id) {
					array_delete(ignored_units, i, 1);
					break;
				}
			}
		}
	};

	var _time_source = time_source_create(
		time_source_game, .1, time_source_units_seconds, remove_from_ignored, [self, _unit]);

	time_source_start(_time_source);
}