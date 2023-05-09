extends CharacterBody2D


class_name Enemy


var gale_force_strength: float
var build_timer: Timer = Timer.new()


func _super() -> void:
	# Add build timer
	build_timer.one_shot = true
	build_timer.connect('timeout', _on_build_trap)
	add_child(build_timer)

func hit_by_gale_force(duration: float, strength: float) -> void:
	gale_force_strength = strength
	await get_tree().create_timer(duration).connect('timeout', func(): gale_force_strength = 0)


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

	if gale_force_strength:
		velocity *= -gale_force_strength

	move_and_slide()


func build_trap(build_time):
	build_timer.wait_time = build_time
	build_timer.start()


func _on_build_trap():
	var trap = load([
		'res://Abilities/SpikeTrap/spike_trap.tscn',
		'res://Abilities/PoisonTrap/poison_trap.tscn'
	].pick_random()).instantiate()

	var trap_size = $Sprite2D.texture.get_size()
	trap.position = position + Vector2(trap_size.x * [-1, 1].pick_random(), trap_size.y * [-1, 1].pick_random())
	get_parent().add_child(trap)
