extends Control


@export var first_level: PackedScene = load('res://Levels/test_level.tscn')
@export var highscore: PackedScene = load('res://Menu/Highscore/highscore.tscn')
@export var credits: PackedScene = load('res://Menu/Credits/credits.tscn')


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_highscore_pressed() -> void:
	get_tree().change_scene_to_packed(highscore)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_packed(credits)
