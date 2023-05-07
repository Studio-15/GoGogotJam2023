extends CharacterBody2D

@onready var stats: entity_stats = $Stats


func _ready() -> void:
	$FoW.visible = true


func _physics_process(delta: float) -> void:
	var velocity_x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	var velocity_y = Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")

	velocity = Vector2(velocity_x, velocity_y).normalized() * stats.MOVE_SPEED

	move_and_slide()


func on_death():
	get_tree().quit()


func take_damage(val: int):
	stats.take_damage(val)
