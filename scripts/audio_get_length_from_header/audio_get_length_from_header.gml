function audio_get_length_from_header(_header) {
	var _data = _header.data;
	var _fmt = _header.fmt;
	return _data.size / (_fmt.sample_rate * _fmt.num_channels * _fmt.bits_per_sample / 8);
}