extends Enemy


@onready var stats: entity_stats = $Stats
@onready var nav_agent = $NavigationAgent2D
@onready var rng = RandomNumberGenerator.new()
var target: CharacterBody2D
var pause: bool = false
var current_state: Enums.ENEMY_STATE = Enums.ENEMY_STATE.IDLE:
	set(val):
		current_state = val
		if val == Enums.ENEMY_STATE.IDLE:
			nav_agent.target_desired_distance = 10
		else:
			nav_agent.target_desired_distance = 135
var idle_points: Array = []
var next_idle_location: int = 0
var enemy_type: Enums.ENEMY_TYPE = Enums.ENEMY_TYPE.RUNNER


func _enter_tree() -> void:
	_super()


func _ready() -> void:
	nav_agent.max_speed = stats.MOVE_SPEED
	set_idle_points()
	current_state = Enums.ENEMY_STATE.IDLE
	build_trap(1)


func _physics_process(delta: float) -> void:
	if pause:
		return
	handle_state()


func take_damage(val: int):
	current_state = Enums.ENEMY_STATE.ENRAGED
	stats.take_damage(val)


func on_death():
	EventBus.enemy_death(enemy_type)
	queue_free()


func handle_state():
	match current_state:
		Enums.ENEMY_STATE.IDLE:
			nav_agent.set_target_position(idle_points[next_idle_location])
			chase()
		Enums.ENEMY_STATE.CHASING:
			var potential_distractions = $DistractionArea.get_overlapping_bodies()
			for pot_dist in potential_distractions:
				if pot_dist.is_in_group("Flora"):
					target = pot_dist
					break
			if is_instance_valid(target):
				nav_agent.set_target_position(target.global_position)
				chase()
			else:
				current_state = Enums.ENEMY_STATE.IDLE
		Enums.ENEMY_STATE.ENRAGED:
			if is_instance_valid(target):
				nav_agent.set_target_position(target.global_position)
			chase()


func set_idle_points():
	idle_points = [
		global_position + (Vector2(1,0) * 100),
		global_position + (Vector2(1,1) * 100),
		global_position + (Vector2(0,1) * 100),
		global_position + (Vector2(1,-1) * 100),
		global_position + (Vector2(0,-1) * 100),
		global_position + (Vector2(-1,-1) * 100),
		global_position + (Vector2(-1,0) * 100),
		global_position + (Vector2(-1,1) * 100),
		global_position
	]


func chase():
	var next_loc = nav_agent.get_next_path_position()
	var new_velocity = (next_loc - global_position).normalized() * (stats.MOVE_SPEED / (1 if current_state != Enums.ENEMY_STATE.IDLE else 8))
	nav_agent.set_velocity(new_velocity)


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
		print(stats.ATTACK_COOLDOWN)
		velocity = Vector2.ZERO
		pause = false
		current_state = Enums.ENEMY_STATE.CHASING # Not sure if this is the intended behaviour we want, but lets test it out -> It goes full berserk mode until it hits the player, and then it can be distracted again.


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if current_state != Enums.ENEMY_STATE.ENRAGED:
			current_state = Enums.ENEMY_STATE.CHASING
		target = body
