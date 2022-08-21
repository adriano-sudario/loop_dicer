//enum STEP_EVENT { BEGIN_STEP, STEP, END_STEP }

enum TWEEN_MODE 
{
	PERSIST, BACK_AND_PERSIST,
	ONE_SHOT, BACK_AND_SHOOT,
	LOOP, YOYO, RESTART
}

enum TWEEN_MODIFIER
{ 
	HORIZONTAL_POSITION, VERTICAL_POSITION, DIAGONAL_POSITION,
	WIDTH, HEIGHT, SIZE,
	OPACITY, COLOR, ANGLE, CUSTOM,
}

instance = noone;
on_finish = noone;
step_to_update = STEP_EVENT.STEP;
mode = TWEEN_MODE.PERSIST;
modifier = TWEEN_MODIFIER.CUSTOM;
initial_value = 0;
current_value = 0;
target_value = 0;
ease_function = linear;
curve_channel = noone;
duration = 0;
elapsed_time = 0;
percent = 0;
is_reverse = false;
modifier_name = "";
finished_count = 0;
is_paused = false;

function reset_target_value(_target_value, _modifier = noone) {
	if (_modifier != noone)
		modifier = _modifier;
	target_value = _target_value;
	set_initial_value();
}

function set_initial_value() {
	switch (modifier)
    {
        case TWEEN_MODIFIER.HORIZONTAL_POSITION:
			initial_value = instance.x;
            break;

        case TWEEN_MODIFIER.VERTICAL_POSITION:
			initial_value = instance.y;
            break;
			
		case TWEEN_MODIFIER.DIAGONAL_POSITION:
			initial_value = { x: instance.x, y: instance.y };
			if (typeof(target_value) != "struct")
				target_value = { x: target_value, y: target_value };
            break;

        case TWEEN_MODIFIER.WIDTH:
			initial_value = instance.image_xscale;
            break;
		
		case TWEEN_MODIFIER.HEIGHT:
			initial_value = instance.image_yscale;
            break;
		
		case TWEEN_MODIFIER.SIZE:
			initial_value = { width: instance.image_xscale, height: instance.image_yscale };
			if (typeof(target_value) != "struct")
				target_value = { width: target_value, height: target_value };
            break;

        case TWEEN_MODIFIER.OPACITY:
			initial_value = instance.image_alpha;
            break;
		
		case TWEEN_MODIFIER.COLOR:
			initial_value = {
				r: color_get_red(instance.image_blend),
				g: color_get_green(instance.image_blend),
				b: color_get_blue(instance.image_blend),
				a: instance.image_alpha
			};
			
			if (typeof(target_value) != "struct")
				target_value = { 
					r: color_get_red(target_value),
					g: color_get_green(target_value),
					b: color_get_red(target_value),
					a: instance.image_alpha
				};
			else if (!variable_struct_exists(target_value, "a"))
				target_value.a = instance.image_alpha;
			
			target_value.r = clamp(target_value.r, 0, 255);
			target_value.g = clamp(target_value.g, 0, 255);
			target_value.b = clamp(target_value.b, 0, 255);
			target_value.a = clamp(target_value.a, 0, 1);
            break;
		
		case TWEEN_MODIFIER.ANGLE:
			initial_value = instance.image_angle;
            break;
			
		case TWEEN_MODIFIER.CUSTOM:
			initial_value = variable_instance_get(instance.id, modifier_name);
            break;
    }
}

function modify()
{
    switch (modifier)
    {
        case TWEEN_MODIFIER.HORIZONTAL_POSITION:
            instance.x = lerp(initial_value, target_value, current_value);
            break;

        case TWEEN_MODIFIER.VERTICAL_POSITION:
            instance.y = lerp(initial_value, target_value, current_value);
            break;
			
		case TWEEN_MODIFIER.DIAGONAL_POSITION:
			instance.x = lerp(initial_value.x, target_value.x, current_value);
            instance.y = lerp(initial_value.y, target_value.y, current_value);
            break;

        case TWEEN_MODIFIER.WIDTH:
            instance.image_xscale = lerp(initial_value, target_value, current_value);
            break;
		
		case TWEEN_MODIFIER.HEIGHT:
            instance.image_yscale = lerp(initial_value, target_value, current_value);
            break;
		
		case TWEEN_MODIFIER.SIZE:
            instance.image_xscale = lerp(initial_value.width, target_value.width, current_value);
			instance.image_yscale = lerp(initial_value.height, target_value.height, current_value);
            break;

        case TWEEN_MODIFIER.OPACITY:
			instance.image_alpha = lerp(initial_value, target_value, current_value);
            break;
			
		case TWEEN_MODIFIER.COLOR:
			var r = lerp(initial_value.r, target_value.r, current_value);
			var g = lerp(initial_value.g, target_value.g, current_value);
			var b = lerp(initial_value.b, target_value.b, current_value);
			r = clamp(r, 0, 255);
			g = clamp(g, 0, 255);
			b = clamp(b, 0, 255);
			instance.image_blend = make_color_rgb(r, g, b);
			instance.image_alpha = lerp(initial_value.a, target_value.a, current_value);
            break;
		
		case TWEEN_MODIFIER.ANGLE:
            instance.image_angle = lerp(initial_value, target_value, current_value);
            break;
		
		case TWEEN_MODIFIER.CUSTOM:
			variable_instance_set(
				instance.id, modifier_name, lerp(initial_value, target_value, current_value));
            break;
    }
}

function update()
{
	if (!instance_exists(instance)) {
		stop();
		return;
	}
	
	if (is_paused)
		return;
		
	elapsed_time += delta_time / 1000000;

	if (elapsed_time >= duration)
	{
		finish();
		return;
	}
	
    percent = clamp(min(elapsed_time, duration) / duration, 0, 1);

    if (is_reverse)
        percent = 1 - percent;

    increment();
}

function increment()
{
	if (curve_channel != noone)
		current_value = animcurve_channel_evaluate(curve_channel, percent);
    else
        current_value = ease_function(percent);

	modify();
}

function get_loop_cycles_count() {
	if (finished_count <= 1)
		return 0;
	else if (has_completed_loop_cycle())
		return finished_count / 2;
	else
		return (finished_count - 1) / 2;
}

function has_completed_loop_cycle() {
	return finished_count % 2 == 0;
}

function finish()
{
	if (is_reverse)
		percent = 0;
	else
		percent = 1;

    increment();

	finished_count++;
	
	var _finish = function() {
		if (on_finish != noone)
			method(instance.id, on_finish)(self);
	}

    switch (mode)
    {
        case TWEEN_MODE.PERSIST:
			is_active = false;
            instance_destroy();
            break;
			
		case TWEEN_MODE.BACK_AND_PERSIST:
            if (has_completed_loop_cycle()) {
				is_reverse = true;
				_finish();
				start();
			} else {
				_finish();
				stop();
			}
            break;

        case TWEEN_MODE.ONE_SHOT:
			is_active = false;
            instance_destroy(instance);
            instance_destroy();
            break;
			
		case TWEEN_MODE.BACK_AND_SHOOT:
            if (has_completed_loop_cycle()) {
				is_reverse = true;
				_finish();
				start();
			} else {
				_finish();
				instance_destroy(instance);
				stop();
			}
            break;

        case TWEEN_MODE.LOOP:
			var initial_started_value = initial_value;
			initial_value = target_value;
			target_value = initial_started_value;
			initial_started_value = initial_value;
			_finish();
            start();
            break;

        case TWEEN_MODE.YOYO:
			is_reverse = !is_reverse;
			_finish();
            start();
            break;

        case TWEEN_MODE.RESTART:
			_finish();
            start();
            break;
    }
}

function start()
{
	unpause();
	elapsed_time = 0;
    current_value = 0;
    percent = 0;
}

function pause() {
	is_paused = true;
}

function unpause() {
	is_paused = false;
}

function stop() {
	instance_destroy();
}