function LoopManager(
	_bpm,
	_compass,
	_owner = other,
	_on_beat = function() { },
	_on_compass_end = function() { },
	_frac_tolerance = .1,
	_sample_rate = 44_100,
	_channel_type = audio_stereo,
	_format_type = buffer_s16) constructor
{
	owner = _owner;
	bpm = _bpm;
	compass = _compass;
	current_compass_beat = 0;
	interval_duration = time_bpm_to_seconds(_bpm);
	channels = _channel_type == audio_mono ? 1 : 2;
	bits_per_sample = _format_type == buffer_u8 ? 8 : 16;
	size = ceil(interval_duration * _sample_rate * channels * bits_per_sample / 8);
	on_beat = _on_beat;
	on_compass_end = _on_compass_end;
	frac_tolerance = _frac_tolerance;
	sample_rate = _sample_rate;
	channel_type = _channel_type;
	format_type = _format_type;
	current_offset = 0;
	is_active = false;
	is_paused = false;
	queue = noone;
	play_index = noone;
	samples = [];
	buffers_on_queue = 64;
	cycle_length = CYCLE_LENGTH;
	
	function GetCurrentPosition() {
		return current_offset / (sample_rate * channels * bits_per_sample / 8);
	}
	
	function GetCurrentLengthPercent() {
		return GetCurrentPosition() / interval_duration;
	}
	
	function GetSampleIndex(_sample_sound) {
		for (var i = 0; i < array_length(samples); i++)
			if (samples[i] == _sample_sound)
				return i;
		
		return -1;
	}
	
	function GetSample(_sample_sound) {
		var _index = GetSampleIndex(_sample_sound);
		
		return _index < 0 ? noone : samples[_index];
	}
	
	function AddSample(_sample) {
		_sample.Load(self);
			
		if (is_active) {
			for (var i = 0; i < array_length(samples); i++) {
				samples[i].current_offset = samples[i].GetOffsetFromManager();
				samples[i].Pause();
			}
		
			_sample.current_offset = _sample.GetOffsetFromManager();
			_sample.Play();
			
			for (var i = 0; i < array_length(samples); i++)
				samples[i].Play();
		}
		
		array_push(samples, _sample);
	}
	
	function RemoveSample(_sample_sound) {
		var _index = GetSampleIndex(_sample_sound);
		
		if (_index >= 0) {
			_sample_sound.Stop();
			array_delete(samples, _index, 1);
		}
	}
	
	function Restart() {
		current_offset = 0;
		current_compass_beat++;
		
		if (current_compass_beat >= compass) {
			current_compass_beat = 0;
			
			for (var i = 0; i < array_length(samples); i++) {
				var _sample = samples[i];
				_sample.current_compass++;
			
				if (_sample.current_compass >= _sample.compasses)
					_sample.Restart();
			}
			
			method(owner.id, on_compass_end)(self);
		}
	}
	
	function Pause(_include_samples = true) {
		audio_stop_sound(play_index);
		audio_free_play_queue(queue);
		queue = noone;
		play_index = noone;
		is_active = false;
		is_paused = true;
		
		if (_include_samples)
			for (var i = 0; i < array_length(samples); i++)
				samples[i].Pause();
	}
	
	function Stop(_include_samples = true) {
		Pause(false);
		current_offset = 0;
		is_paused = false;
		
		if (_include_samples)
			for (var i = 0; i < array_length(samples); i++)
				samples[i].Stop();
	}
	
	function GetSampleSize() {
		return current_offset + cycle_length > size ? size - current_offset : cycle_length;
	}
	
	function Update() {
		var _sample_size = GetSampleSize();
		var _sample_buff = buffer_create(_sample_size, buffer_fixed, 1);
		buffer_fill(_sample_buff, 0, format_type, 0, _sample_size);
		audio_queue_sound(queue, _sample_buff, 0, _sample_size);
	
		if (current_offset + _sample_size >= size)
			Restart();
		else
			current_offset += cycle_length;
	}
	
	function UpdatePlayback() {
		for (var i = 0; i < array_length(samples); i++)
			samples[i].UpdatePlayback();
		
		if (async_load[? "queue_id"] != queue || async_load[? "queue_shutdown"])
			return;
		
		if (current_offset == 0 && is_active)
			method(owner.id, on_beat)(self);
		
		buffer_delete(async_load[? "buffer_id"]);
		Update();
	}
	
	function Arm() {
		queue = audio_create_play_queue(format_type, sample_rate, channel_type);
		
		for (var i = 0; i < buffers_on_queue; i++)
			Update();
	}

	function Start() {
		for (var i = 0; i < array_length(samples); i++)
			samples[i].Play();
		
		if (queue == noone)
			Arm();
		
		play_index = audio_play_sound(queue, 100, false);
		
		audio_sound_gain(play_index, 0, 0);
		
		is_active = true;
		is_paused = false;
	}
	
	function Resume(_include_samples = true) {
		Start();
		
		if (_include_samples)
			for (var i = 0; i < array_length(samples); i++)
				samples[i].Resume();
	}
	
	function Dispose() {
		Stop(false);
		
		for (var i = 0; i < array_length(samples); i++)
			samples[i].Dispose();
	}
	
	function HasPausedUnpredictably() {
		return is_active && !audio_is_playing(play_index);
	}
	
	function ResumeIfPausedUnpredictably() {
		if (HasPausedUnpredictably()) {
			Resume(false);
			
			for (var i = 0; i < array_length(samples); i++) {
				samples[i].current_offset = samples[i].GetOffsetFromManager();
				samples[i].Resume();
			}
		} else {
			for (var i = 0; i < array_length(samples); i++)
				samples[i].ResumeIfPausedUnpredictably();
		}
	}
	
	function UpdateStep() {
		if (HasPausedUnpredictably()) {
			Resume(false);
			
			for (var i = 0; i < array_length(samples); i++) {
				samples[i].current_offset = samples[i].GetOffsetFromManager();
				samples[i].Resume();
			}
		}
		
		for (var i = 0; i < array_length(samples); i++)
			samples[i].UpdateStep();
	}
}