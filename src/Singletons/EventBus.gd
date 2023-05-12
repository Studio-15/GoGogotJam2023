extends Node


signal scene_loaded_signal
signal load_new_scene_signal
signal enemy_death_signal
signal level_complete_signal


func scene_loaded():
	emit_signal("scene_loaded_signal")


func load_new_scene():
	emit_signal("load_new_scene_signal")


func enemy_death(type: Enums.ENEMY_TYPE):
	emit_signal("enemy_death_signal", type)


func level_complete():
	emit_signal("level_complete_signal")
