function LoopManagerSample(_file_path) : WavSound(_file_path) constructor
{
	compasses = 0;
	current_compass = 0;
	manager = noone;
	
	function Load(_manager) {
		var _compasses = length / (_manager.interval_duration * _manager.compass);
		compasses = frac(_compasses) <= _manager.frac_tolerance ? floor(_compasses) : ceil(_compasses);
		current_compass = 0;
		manager = _manager;
	}
	
	function Restart() {
		current_offset = header.data.offset;
		current_compass = 0;
		
		if (is_playing && !audio_is_playing(play_index))
			Play();
	}
	
	function Update() {
		var _sample_size = current_offset + manager.cycle_length > header.data.size
			? header.data.size - current_offset
			: manager.cycle_length;
		
		if (_sample_size <= 0) {
			current_offset = file_size;
			return;
		}
		
		var _sample_buff = buffer_create(_sample_size, buffer_fast, 1);
		buffer_copy(file_buffer, current_offset, _sample_size, _sample_buff, 0);
		audio_queue_sound(queue, _sample_buff, 0, _sample_size);
		
		buffers_added++;
		current_offset += manager.cycle_length;
	}
	
	function AddBuffers() {
		var _buffers_to_add = manager.buffers_on_queue - buffers_added;
		
		for (var i = 0; i < _buffers_to_add; i++) {
			Update();
			
			if (current_offset >= file_size)
				break;
		}
	}
	
	function UpdatePlayback() {
		if (async_load[? "queue_id"] != queue || async_load[? "queue_shutdown"])
			return;
		
		if (change_on_next_update != noone) {
			buffer_delete(file_buffer);
			file_path = change_on_next_update.file_path;
			file_buffer = change_on_next_update.file_buffer;
			header = change_on_next_update.header;
			length = header.GetLengthInSeconds();
			file_size = header.riff.size + 8;
			current_offset = current_offset - header.data.offset;
			change_on_next_update = noone;
		}
		
		buffer_delete(async_load[? "buffer_id"]);
		buffers_added--;
		
		AddBuffers();
	}
	
	function Arm() {
		if (queue == noone)
			queue = audio_create_play_queue(
				header.GetFormatType(), header.fmt.sample_rate, header.GetChannelType());
		
		AddBuffers();
	}
	
	function GetOffsetFromManager() {
		var _beat_offset = manager.current_compass_beat + (current_compass * manager.compass);
		var _offset = header.data.offset + manager.current_offset + (_beat_offset * manager.size);
		return _offset * header.fmt.num_channels / manager.channels;
	}
}