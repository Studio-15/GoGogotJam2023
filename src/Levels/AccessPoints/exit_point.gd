extends Node2D

@export var next_scene: int = 0

func _ready() -> void:
	EventBus.level_complete_signal.connect(on_level_complete)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		SceneManager.change_scenes(next_scene)


func on_level_complete():
	var TW_left = create_tween()
	TW_left.tween_property($Left, "position:x", $Left.position.x - 100, 2.0)
	var TW_right = create_tween()
	TW_right.tween_property($Right, "position:x", $Right.position.x + 100, 2.0)
