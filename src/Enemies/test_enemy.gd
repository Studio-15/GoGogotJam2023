extends CharacterBody2D

@onready var stats: entity_stats = $Stats
@onready var nav_agent = $NavigationAgent2D
var target: CharacterBody2D
var pause: bool = false

func _ready() -> void:
	nav_agent.max_speed = stats.MOVE_SPEED


func _physics_process(delta: float) -> void:
	if pause:
		return
	if target:
		nav_agent.set_target_position(target.global_position)
		var next_loc = nav_agent.get_next_path_position()
		var new_velocity = (next_loc - global_position).normalized() * stats.MOVE_SPEED
		nav_agent.set_velocity(new_velocity)


func take_damage(val: int):
	stats.take_damage(val)


func on_death():
	queue_free()


func _on_navigation_agent_2d_target_reached() -> void:
	if pause:
		return
	pause = true
	target.take_damage(stats.ATTACK)
	await get_tree().create_timer(stats.ATTACK_COOLDOWN).timeout
	velocity = Vector2.ZERO
	pause = false


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		target = body


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
