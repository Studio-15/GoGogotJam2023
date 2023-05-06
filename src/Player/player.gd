extends CharacterBody2D

var move_speed = 300


func _physics_process(delta: float) -> void:
	var velocity_x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	var velocity_y = Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")

	velocity = Vector2(velocity_x, velocity_y) * move_speed

	move_and_slide()
