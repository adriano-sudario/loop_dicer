function WavHeader(_file, _read_from_path = true) constructor
{
	if (_read_from_path && !file_exists(_file))
		throw "File not found.";
	
    var _file_buff = _read_from_path ? buffer_load(_file) : _file;
	
	riff = {
		id: audio_get_header_value(_file_buff, 0, 4, true),
		size: audio_get_header_value(_file_buff, 4, 4),
		format: audio_get_header_value(_file_buff, 8, 4, true)
	};
	fmt = {
		id: audio_get_header_value(_file_buff, 12, 4, true),
		size: audio_get_header_value(_file_buff, 16, 4),
		audio_format: audio_get_header_value(_file_buff, 20, 2),
		num_channels: audio_get_header_value(_file_buff, 22, 2),
		sample_rate: audio_get_header_value(_file_buff, 24, 4),
		byte_rate: audio_get_header_value(_file_buff, 28, 4),
		block_align: audio_get_header_value(_file_buff, 32, 2),
		bits_per_sample: audio_get_header_value(_file_buff, 34, 2)
	};
	data = {
		id: audio_get_header_value(_file_buff, 36, 4, true),
		size: audio_get_header_value(_file_buff, 40, 4),
		offset: 44
	};
	
	if (string_lower(riff.id) != "riff"
		|| string_trim(fmt.id) != "fmt"
		|| fmt.audio_format != 1)
		throw "File is not a WAVE.";
	
	if (data.id != "data") {
		var _offset = 36;
		var _data_value = [0x64, 0x61, 0x74, 0x61];
		var _data_value_length = array_length(_data_value);
	
		while (true) {
			var _value = buffer_peek(_file_buff, _offset, buffer_u8);
		
			if (_value = _data_value[0]) {
				var _has_found_data_chunk = true;
				
				for (var d = 1; d < _data_value_length; d++) {
					if (buffer_peek(_file_buff, _offset + d, buffer_u8) != _data_value[d]) {
						_has_found_data_chunk = false;
						break;
					}
				}
				
				if (_has_found_data_chunk) {
					_offset += _data_value_length;
					var _data_size_length = 4;
					data = {
						id: "data",
						size: audio_get_header_value(_file_buff, _offset, _data_size_length),
						offset: _offset + _data_size_length
					}
					break;
				}
			}
			
			_offset++;
		}
	}
	
	if (_read_from_path)
		buffer_delete(_file_buff);
	
	static GetFormatType = function() {
		return fmt.bits_per_sample == 8 ? buffer_u8 : buffer_s16;
	}
	
	static GetChannelType = function() {
		switch (fmt.num_channels) {
			case 1:
				return audio_mono;
			
			case 2:
				return audio_stereo;
			
			default:
				return audio_3d;
		}
	}
	
	static GetLengthInSeconds = function() {
		return data.size / (fmt.sample_rate * fmt.num_channels * fmt.bits_per_sample / 8);
	}
}