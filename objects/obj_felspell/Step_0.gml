if (owner == noone)
	return;

x = owner.x;
y = owner.y;

image_xscale = scale;
image_yscale = scale;

for (var i = 0; i < instance_number(obj_slime); ++i;)
{
	var _slime = instance_find(obj_slime, i);
	
	if (collision_circle(x, y, (radius * scale), _slime, false, true))
		apply_damage(_slime);
}