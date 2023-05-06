extends CharacterBody2D

@onready var stats: entity_stats = $Stats
@onready var nav_agent = $NavigationAgent2D
var target: CharacterBody2D


#func _physics_process(delta: float) -> void:
#	if target:
#
#		var next_loc = nav_agent.get_next_path_position()
#		var new_velocity = (next_loc - global_position).normalized() * stats.SPEED
#
#		nav_agent.set_velocity(new_velocity)
#
#
#func _on_navigation_agent_2_velocity_computed(safe_velocity: Vector2) -> void:
#	velocity = velocity.move_toward(safe_velocity, 0.9)
#	move_and_slide()
#
#
#func _on_navigation_agent_3d_target_reached() -> void:
#	if pause:
#		return
#	pause = true
#	target.take_damage(stats.ATTACK)
#	await get_tree().create_timer(0.6).timeout
#	pause = false


func on_death():
	queue_free()


func take_damage(val: int):
	stats.take_damage(val)
