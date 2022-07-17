damage = 1;
ignored_units = [];

function apply_damage(_unit) {
	if (obj_gameplay.is_chosing_dice || !instance_exists(_unit))
		return;

	for (var i = 0; i < array_length(ignored_units); i++)
		if (!instance_exists(ignored_units[i]) || _unit.id == ignored_units[i].id)
			return;

	_unit.take_damage(damage);
	array_push(ignored_units, _unit);
}