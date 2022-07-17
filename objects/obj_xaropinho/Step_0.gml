image_angle += spinning_velocity;

if (abs(image_angle) >= 360)
	image_angle = 0;

if (x <= -100 || x >= room_width + 100
	|| y <= -100 || y >= room_height + 100)
	instance_destroy();