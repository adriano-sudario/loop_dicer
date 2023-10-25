#macro BPM 155
#macro COMPASS 4

samples = [];
samples_to_play_on_next_compass = [];
samples_to_stop_on_next_compass = [];
loop = noone;
is_debug_on = true;

function add_sample(_sample) {
	loop.manager.AddSample(_sample);
	
	with (obj_dice)
		stop_roll();
}

function on_compass_end(_loop) {
	for (var i = 0; i < array_length(samples); i++)
		with (samples[i])
			on_compass_end(_loop);
	
	for (var i = 0; i < array_length(samples_to_play_on_next_compass); i++)
		add_sample(samples_to_play_on_next_compass[i].sample)
	
	samples_to_play_on_next_compass = [];
	samples_to_stop_on_next_compass = [];
}

function on_beat_end(_loop) {
	for (var i = 0; i < array_length(samples); i++)
		with (samples[i])
			on_beat_end(_loop);
}

function play_on_next_compass(_sample_object) {
	array_push(samples, _sample_object);
	
	if (loop == noone) {
		loop = instance_create_layer(50, 50, layer, obj_loop);
		loop.manager = new LoopManager(BPM, COMPASS, , on_beat_end, on_compass_end);
		add_sample(_sample_object.sample);
		loop.manager.Start();
		return;
	}
	
	array_push(samples_to_play_on_next_compass, _sample_object);
}