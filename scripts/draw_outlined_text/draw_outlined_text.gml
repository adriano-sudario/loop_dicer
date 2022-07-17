/// @function draw_outlined_text(x, y, text, text_color, alpha, border_color)

function draw_outlined_text(_x, _y, _text, _text_color = c_white, _alpha = 1, _border_color = c_black) {
	var offset = 2;
	
	for (var o = 0; o < 4; o++) {
		if (o < 2)
			draw_text_color(_x + (offset * (o % 2 == 0 ? 1 : -1)), _y, _text,
				_border_color, _border_color, _border_color, _border_color, _alpha);
		else
			draw_text_color(_x, _y + (offset * (o % 2 == 0 ? 1 : -1)), _text,
				_border_color, _border_color, _border_color, _border_color, _alpha);
	}
	
	draw_text_color(_x, _y, _text, 
		_text_color, _text_color, _text_color, _text_color, _alpha);
}