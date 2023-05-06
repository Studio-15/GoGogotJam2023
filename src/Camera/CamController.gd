extends Camera2D


@onready var player: CharacterBody2D = get_parent().get_node("Player")


#func _physics_process(delta: float) -> void:
#	global_position = Vector2(lerp(global_position.x, player.global_position.x, 0.05), lerp(global_position.y, player.global_position.y, 0.05))
