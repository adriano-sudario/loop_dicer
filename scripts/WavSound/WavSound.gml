#macro CYCLE_LENGTH 256

function WavSound(_file_path, _is_looping = true) constructor
{
	file_path = _file_path;
	file_buffer = buffer_load(file_path);
	header = new WavHeader(file_buffer, false);
	length = header.GetLengthInSeconds();
	file_size = header.riff.size + 8;
	current_offset = header.data.offset;
	change_on_next_update = noone;
	is_looping = _is_looping;
	is_playing = false;
	is_paused = false;
	buffers_added = 0;
	queue = noone;
	play_index = noone;
	loop_points = { start: header.data.offset, finish: file_size };
	
	function GetCurrentPosition() {
		var _fmt = header.fmt;
		var _size = current_offset - header.data.offset;
		return _size / (_fmt.sample_rate * _fmt.num_channels * _fmt.bits_per_sample / 8);
	}
	
	function GetCurrentLengthPercent() {
		return GetCurrentPosition() / length;
	}
	
	function Restart() {
		current_offset = loop_points.start;
	}
	
	function SetPosition(_position_seconds) {
		var _fmt = header.fmt;
		var _offset = _position_seconds * (_fmt.sample_rate * _fmt.num_channels * _fmt.bits_per_sample / 8);
		current_offset = round(header.data.offset + _offset);
	}
	
	function SetStartLoopPoint(_position_seconds) {
		var _fmt = header.fmt;
		var _offset = _position_seconds * (_fmt.sample_rate * _fmt.num_channels * _fmt.bits_per_sample / 8);
		loop_points.start = round(header.data.offset + _offset);
	}
	
	function SetFinishLoopPoint(_position_seconds) {
		var _fmt = header.fmt;
		var _offset = _position_seconds * (_fmt.sample_rate * _fmt.num_channels * _fmt.bits_per_sample / 8);
		loop_points.finish = round(header.data.offset + _offset);
	}
	
	function SetLoopRange(_range) {
		SetStartLoopPoint(_range.start);
		SetFinishLoopPoint(_range.finish);
	}
	
	function ResetLoopPoints() {
		loop_points = { start: header.data.offset, finish: file_size };
	}
	
	function IsCustomLoopRangeSet() {
		return loop_points.start != header.data.offset && loop_points.finish != file_size;
	}
	
	function ChangeFile(_file_path) {
		var _file_buffer = buffer_load(_file_path);
		var _header = new WavHeader(_file_buffer, false);
		if (is_playing) {
			change_on_next_update = {
				file_path: _file_path,
				file_buffer: _file_buffer,
				header: _header,
				length: _header.GetLengthInSeconds(),
				file_size: _header.riff.size + 8
			};
		} else {
			buffer_delete(file_buffer);
			file_path = _file_path;
			file_buffer = _file_buffer;
			header = _header;
			length = _header.GetLengthInSeconds();
			file_size = _header.riff.size + 8;
			current_offset = header.data.offset;
		}
	}
	
	function Pause() {
		audio_stop_sound(play_index);
		audio_free_play_queue(queue);
		queue = noone;
		play_index = noone;
		is_playing = false;
		is_paused = true;
	}
	
	function Stop() {
		Pause();
		current_offset = header.data.offset;
		is_paused = false;
		buffers_added = 0;
	}
	
	function Update() {
		var _sample_size = current_offset + CYCLE_LENGTH > file_size
			? file_size - current_offset
			: CYCLE_LENGTH;
		var _sample_buff = buffer_create(_sample_size, buffer_fast, 1);
		buffer_copy(file_buffer, current_offset, _sample_size, _sample_buff, 0);
		audio_queue_sound(queue, _sample_buff, 0, _sample_size);
		
		buffers_added++;
		
		if (current_offset + _sample_size >= loop_points.finish)
			Restart();
		else
			current_offset += CYCLE_LENGTH;
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
		
		if (!is_looping && current_offset == header.data.offset && is_playing) {
			Stop();
			return;
		}
		
		Update();
	}
	
	function Arm() {
		var _fmt = header.fmt;
		
		if (queue == noone)
			queue = audio_create_play_queue(
				header.GetFormatType(), _fmt.sample_rate, header.GetChannelType());
		
		var _buffers_to_add = _fmt.block_align * _fmt.bits_per_sample;
		
		for (var i = 0; i < _buffers_to_add; i++) {
			Update();
			
			if (!is_looping && current_offset >= loop_points.finish)
				break;
		}
	}

	function Play() {
		Arm();
		play_index = audio_play_sound(queue, 100, false);
		is_playing = true;
		is_paused = false;
	}
	
	function Resume() {
		Play();
	}
	
	function Dispose() {
		Stop();
		buffer_delete(file_buffer);
	}
	
	function HasPausedUnpredictably() {
		return is_playing && (!audio_is_playing(play_index) || buffers_added == 0);
	}
	
	function ResumeIfPausedUnpredictably() {
		if (HasPausedUnpredictably())
			Resume();
	}
	
	function UpdateStep() {
		ResumeIfPausedUnpredictably();
	}
}