extends RigidBody2D


func _ready() -> void:
	linear_velocity = Vector2(randf_range(-20, 20), randf_range(-40, -60))
	angular_velocity = randf_range(-1, 1)


func set_number(number: int) -> void:
	$Label.text = str(number)
