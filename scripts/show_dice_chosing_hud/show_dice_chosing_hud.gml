function show_dice_chosing_hud() {
	instance_create_layer(0, 0, "HUD", obj_dice_chosing_hud);
	obj_gameplay.is_chosing_dice = true;
}