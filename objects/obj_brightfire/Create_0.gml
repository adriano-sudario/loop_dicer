event_inherited();

scale = 1.5;
image_xscale = scale;
image_yscale = scale * 2;
name = "brightfire ambience";
sample = new LoopManagerSample("lp_ambience_brightfire.wav");

function change() {
	if (owner == noone)
		return;
	
	image_angle = random_range(0, 360);
}

function on_compass_end(_loop) {
	change();
}