if (image_index < 17 || image_index >= 26)
	return;

for (var i = 0; i < array_length(ignored_units); i++)
	if (other.id == ignored_units[i].id)
		return;

other.take_damage(damage);
array_push(ignored_units, other);