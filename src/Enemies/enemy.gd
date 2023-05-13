extends CharacterBody2D


class_name Enemy

@onready var nav_agent = $NavigationAgent2D
@onready var rng = RandomNumberGenerator.new()
@onready var stats: entity_stats = $Stats

var target: CharacterBody2D
var next_idle_location: int = 0
var idle_points: Array = []
var gale_force_strength: float
var build_timer: Timer = Timer.new()
var pause: bool = false
var current_state: Enums.ENEMY_STATE = Enums.ENEMY_STATE.IDLE:
	set(val):
		current_state = val
		if val == Enums.ENEMY_STATE.IDLE:
			nav_agent.target_desired_distance = 10
		else:
			nav_agent.target_desired_distance = 135


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


func _on_navigation_agent_2d_target_reached() -> void:
	if pause:
		return
	if current_state == Enums.ENEMY_STATE.IDLE:
		var randint = rng.randi_range(0, len(idle_points)-1)
		next_idle_location = randint
	elif current_state in [Enums.ENEMY_STATE.CHASING, Enums.ENEMY_STATE.ENRAGED]:
		if !is_instance_valid(target):
			return
		pause = true
		target.take_damage(stats.ATTACK)
		await get_tree().create_timer(stats.ATTACK_COOLDOWN).timeout
		velocity = Vector2.ZERO
		pause = false
		# Not sure if this is the intended behaviour we want,but lets test it 
		# out -> It goes full berserk mode until it hits the player, and then 
		# it can be distracted again.
		current_state = Enums.ENEMY_STATE.CHASING 
