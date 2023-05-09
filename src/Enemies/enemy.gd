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


func build_trap(build_time, cooldown_after_setup):
	get_tree().create_timer(build_time).connect('timeout', _on_build_trap.bind(cooldown_after_setup))


func _on_build_trap(cooldown_after_setup):
	var trap = load([
		'res://Abilities/SpikeTrap/spike_trap.tscn'
	].pick_random()).instantiate()

	trap.cooldown_after_setup = cooldown_after_setup
	trap.position = global_position
	get_parent().add_child(trap)
