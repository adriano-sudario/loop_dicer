scale = .25;
image_xscale = scale;
image_yscale = scale;
duration = time_bpm_to_seconds(155);

function explode() {
	instance_create_layer(x, y, layer, obj_nebula_explosion);
	instance_destroy();
}

wait_for_seconds(duration, explode, true);