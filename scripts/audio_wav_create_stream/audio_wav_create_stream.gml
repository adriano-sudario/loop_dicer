function audio_wav_create_stream(_file_path) {
	if (!file_exists(_file_path))
		return -2;
	
    var _file_buff = buffer_load(_file_path);
    var _file_size = buffer_get_size(_file_buff);
    var _audio_file_buff = buffer_create(_file_size, buffer_fixed, 1);
    buffer_copy(_file_buff, 0, _file_size, _audio_file_buff, 0);
		
	var _file_header = audio_wav_get_header(_file_buff, false);
	buffer_delete(_file_buff);
		
	if (_file_header == -3)
		return _file_header;
	
	if (_file_header.fmt.bits_per_sample != 8 && _file_header.fmt.bits_per_sample != 16)
		return -4;
		
    var _format = (_file_header.fmt.bits_per_sample == 8) ? buffer_u8 : buffer_s16;
    var _channels = (_file_header.fmt.num_channels == 2) ? audio_stereo
		: ((_file_header.fmt.num_channels == 1) ? audio_mono : audio_3d);
	
	var _buffer_sound = audio_create_buffer_sound(
		_audio_file_buff,
		_format,
		_file_header.fmt.sample_rate,
		_file_header.data.offset,
		_file_header.data.size,
		_channels);
	
	return _buffer_sound;
}