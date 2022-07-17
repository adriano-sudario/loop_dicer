for (var i = 0; i < array_length(ignored_units); i++)
	if (other.id == ignored_units[i].id)
		return;

other.take_damage(damage);
array_push(ignored_units, other);
bounces++;
	
if (bounces > max_bounces) {
	instance_destroy();
	return;
}

hspeed = 0;
vspeed = 0;
speed = velocity;
direction = random_range(0, 360);