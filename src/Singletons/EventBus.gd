extends Node


signal scene_loaded_signal
signal load_new_scene_signal


func scene_loaded():
	emit_signal("scene_loaded_signal")


func load_new_scene():
	emit_signal("load_new_scene_signal")
