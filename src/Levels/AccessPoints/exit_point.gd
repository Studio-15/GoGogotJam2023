extends Node2D

@export var next_scene: int = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		SceneManager.change_scenes(next_scene)
