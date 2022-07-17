font_small = fnt_mono_smallest;
font = fnt_mono_small;
font_big = fnt_mono_big;
show_begin_text = false;

function toggle_show_begin_text() {
	show_begin_text = !show_begin_text;
	
	var _toggle= function(_caller)
	{
		with(_caller)
			toggle_show_begin_text();
	}

	var _time_source = time_source_create(
		time_source_game, .5, time_source_units_seconds, _toggle, [self]);

	time_source_start(_time_source);
}

toggle_show_begin_text();