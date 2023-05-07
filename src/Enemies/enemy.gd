extends CharacterBody2D


class_name Enemy


var gale_force_strength: float


func hit_by_gale_force(duration: float, strength: float) -> void:
	gale_force_strength = strength
	await get_tree().create_timer(duration).connect('timeout', func(): gale_force_strength = 0)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

	if gale_force_strength:
		velocity *= -gale_force_strength

	move_and_slide()
