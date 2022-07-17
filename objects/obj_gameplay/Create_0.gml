randomize();

owned_loops = { beat: noone, base: noone, bass: noone, ambience: noone };

dice_options = {
	beat: [
		instance_create_layer(0, 0, "SpellsAfterCharacters", obj_nebula_spawner),
		instance_create_layer(0, 0, "SpellsBeforeCharacters", obj_phantom_spawner)
	],
	base: [
		instance_create_layer(0, 0, "SpellsBeforeCharacters", obj_felspell),
		instance_create_layer(0, 0, "SpellsBeforeCharacters", obj_vortex),
	],
	bass: [
		instance_create_layer(0, 0, "SpellsAfterCharacters", obj_sunburn_spawner),
		instance_create_layer(0, 0, "SpellsAfterCharacters", obj_xaropinho_spawner)
	],
	ambience: [
		instance_create_layer(0, 0, "SpellsBeforeCharacters", obj_brightfire),
		instance_create_layer(0, 0, "SpellsBeforeCharacters", obj_magickahit_spawner)
	]
};
is_chosing_dice = false;
slimes_killed_count = 0;
font = fnt_mono_small;
font_small = fnt_mono_smallest;
show_dice_chosing_hud();