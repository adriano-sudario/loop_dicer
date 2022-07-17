image_xscale = .9;

dice_selected_index = 0;
dice_options = [];
has_chosen = false;

if (obj_gameplay.owned_loops.beat == noone)
	array_push(dice_options,
	{
		dice_instance: instance_create_depth(x, y, depth - 1, obj_dice_beat),
	});

if (obj_gameplay.owned_loops.base == noone)
	array_push(dice_options,
	{
		dice_instance: instance_create_depth(x, y, depth - 1, obj_dice_base),
	});

if (obj_gameplay.owned_loops.bass == noone)
	array_push(dice_options,
	{
		dice_instance: instance_create_depth(x, y, depth - 1, obj_dice_bass),
	});

if (obj_gameplay.owned_loops.ambience == noone)
	array_push(dice_options,
	{
		dice_instance: instance_create_depth(x, y, depth - 1, obj_dice_ambience),
	});

function chose() {
	has_chosen = true;
	var _chosen_dice = dice_options[dice_selected_index];
	_chosen_dice.dice_instance.roll();
	
	for (var i = 0; i < array_length(dice_options); i++) {
		if (i != dice_selected_index)
			instance_destroy(dice_options[i].dice_instance);
	}
	
	dice_options = [_chosen_dice];
	update_options();
}

function update_options() {
	var _dice_width = sprite_get_width(spr_dice_rolling) * DICE_HUD_SCALE;
	var _options_count = array_length(dice_options);
	var _padding = 75;
	var _dice_container_width = (_dice_width + _padding) * (_options_count - 1);

	for (var i = 0; i < array_length(dice_options); i++) {
		var _dice_instance = dice_options[i].dice_instance;
		_dice_instance.is_selected = false;
		
		if (i == dice_selected_index)
			_dice_instance.is_selected = true;
	
		if (i == 0)
			_dice_instance.x = x - (_dice_container_width * .5);
		else
			_dice_instance.x = dice_options[i - 1].dice_instance.x + _dice_width + _padding;
	
		_dice_instance.y = y;
	}
}

function close() {
	for (var i = 0; i < array_length(dice_options); i++)
		instance_destroy(dice_options[i].dice_instance);
	
	obj_gameplay.is_chosing_dice = false;
	
	for (var i = 0; i < instance_number(obj_slime); ++i;)
	{
		var _slime = instance_find(obj_slime, i);
		_slime.move();
	}
	
	instance_destroy();
}