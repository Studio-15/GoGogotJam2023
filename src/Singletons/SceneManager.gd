extends Node

var current_scene_index: int = 0
var scenes: Array = [
	"res://Levels/world_map.tscn",
	"res://Levels/level_0.tscn",
	"res://Levels/level_1.tscn",
	"res://Levels/test_level.tscn",
	"res://Menu/Main/main.tscn"
]


func change_scenes(index: int):
	if index == current_scene_index:
		return
	if index < len(scenes):
		get_tree().change_scene_to_file(scenes[index])
		current_scene_index = index