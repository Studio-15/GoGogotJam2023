extends Control


var main_menu: PackedScene = load('res://Menu/Main/main.tscn')


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
