extends Node2D


var right_pos: int = 4500
var mid_pos: int = 0
var left_pos: int = -4500
var duration: float = 0.5


func _ready() -> void:
	$Container/Sprite2D.visible = true
	EventBus.load_new_scene_signal.connect(on_switch_scene)
	EventBus.scene_loaded_signal.connect(on_scene_switched)
	EventBus.scene_loaded()


func on_scene_switched():
	$Container.position.x = mid_pos
	$Container/Sprite2D.modulate.a = 1.0
	var TW = create_tween()
	TW.tween_property($Container, "position:x", left_pos, duration)
	var TW_opacity = create_tween()
	TW_opacity.tween_property($Container/Sprite2D, "modulate:a", 0.0, duration-0.1)


func on_switch_scene():
	$Container.position.x = right_pos
	$Container/Sprite2D.modulate.a = 0.0
	var TW = create_tween()
	TW.tween_property($Container, "position:x", mid_pos, duration)
	var TW_opacity = create_tween()
	TW_opacity.tween_property($Container/Sprite2D, "modulate:a", 1.0, duration-0.1)
