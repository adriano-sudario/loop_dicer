x = obj_camera.x;
y = obj_camera.y;

update_options();

if (has_chosen)
	return;

if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
	dice_selected_index--;
	
	if (dice_selected_index < 0)
		dice_selected_index = array_length(dice_options) - 1;
	
	update_options();
} else if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
	dice_selected_index++;
	
	if (dice_selected_index >= array_length(dice_options))
		dice_selected_index = 0;
	
	update_options();
} else if (keyboard_check_pressed(vk_space)) {
	chose();
}