function audio_get_header_value(_buff, _offset, _size, _is_text = false) {
	if (_is_text) {
		var _value = "";
		
		for (var i = _offset; i < _offset + _size; i++)
			_value += chr(buffer_peek(_buff, i, buffer_u8));
		
		return _value;
	} else {
		switch (_size) {
			case 1:
				return buffer_peek(_buff, _offset, buffer_u8);
			
			case 2:
				return buffer_peek(_buff, _offset, buffer_u16);
			
			case 4:
				return buffer_peek(_buff, _offset, buffer_u32);
			
			default:
				throw ("error executing method audio_get_header_value: invalid size argument");
		}
	}
}


function audio_wav_get_header(_file, _read_from_path = true) {
	if (_read_from_path && !file_exists(_file))
		return -2;
	
    var _file_buff = _read_from_path ? buffer_load(_file) : _file;
		
	var _header = {
		riff: {
			id: audio_get_header_value(_file_buff, 0, 4, true),
			size: audio_get_header_value(_file_buff, 4, 4),
			format: audio_get_header_value(_file_buff, 8, 4, true)
		},
		fmt: {
			id: audio_get_header_value(_file_buff, 12, 4, true),
			size: audio_get_header_value(_file_buff, 16, 4),
			audio_format: audio_get_header_value(_file_buff, 20, 2),
			num_channels: audio_get_header_value(_file_buff, 22, 2),
			sample_rate: audio_get_header_value(_file_buff, 24, 4),
			byte_rate: audio_get_header_value(_file_buff, 28, 4),
			block_align: audio_get_header_value(_file_buff, 32, 2),
			bits_per_sample: audio_get_header_value(_file_buff, 34, 2)
		},
		data: {
			id: audio_get_header_value(_file_buff, 36, 4, true),
			size: audio_get_header_value(_file_buff, 40, 4),
			offset: 44
		}
	};
	
	if (string_lower(_header.riff.id) != "riff"
		|| string_trim(_header.fmt.id) != "fmt"
		|| _header.fmt.audio_format != 1)
		return -3;
	
	if (_header.data.id != "data") {
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
					_header.data = {
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
	
	return _header;
}