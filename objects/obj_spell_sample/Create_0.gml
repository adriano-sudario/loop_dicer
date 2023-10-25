owner = noone;
name = "";
sample = noone;

function on_compass_end(_loop) {
	
}

function on_beat_end(_loop) {
	
}

function activate(_owner) {
	owner = _owner;
	
	with (obj_loop_manager)
		play_on_next_compass(other);
}