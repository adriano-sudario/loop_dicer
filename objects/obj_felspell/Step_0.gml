if (owner == noone || sample.manager == noone)
	return;

x = owner.x;
y = owner.y;

var scale_increment = sample.manager.GetCurrentLengthPercent() * (max_scale - min_scale);

if (sample.manager.current_compass_beat % 2 == 0)
	scale = min_scale + scale_increment;
else
	scale = max_scale - scale_increment;

image_xscale = scale;
image_yscale = scale;

for (var i = 0; i < instance_number(obj_slime); ++i;)
{
	var _slime = instance_find(obj_slime, i);
	
	if (collision_circle(x, y, (radius * scale), _slime, false, true))
		apply_damage(_slime);
}