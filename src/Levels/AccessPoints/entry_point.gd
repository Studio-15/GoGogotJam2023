extends Node2D

@export var prev_scene: int = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		SceneManager.change_scenes(prev_scene)
