randomize();

owned_loops = { beat: noone, base: noone, bass: noone, ambience: noone };

dice_options = {
	beat: [
		{ layer_name: "SpellsAfterCharacters", object: obj_nebula_spawner },
		{ layer_name: "SpellsBeforeCharacters", object: obj_phantom_spawner }
	],
	base: [
		{ layer_name: "SpellsBeforeCharacters", object: obj_felspell },
		{ layer_name: "SpellsBeforeCharacters", object: obj_vortex }
	],
	bass: [
		{ layer_name: "SpellsAfterCharacters", object: obj_sunburn_spawner },
		{ layer_name: "SpellsAfterCharacters", object: obj_xaropinho_spawner }
	],
	ambience: [
		{ layer_name: "SpellsBeforeCharacters", object: obj_brightfire },
		{ layer_name: "SpellsBeforeCharacters", object: obj_magickahit_spawner }
	]
};
is_chosing_dice = false;
slimes_killed_count = 0;
font = fnt_mono_small;
font_small = fnt_mono_smallest;
show_dice_chosing_hud();