extends CharacterBody2D


@onready var stats: entity_stats = $Stats


var is_dashing: bool = false
var dash_duration: float = 0.2


func _ready() -> void:
	$FoW.visible = true


func _physics_process(delta: float) -> void:
	move(delta)


func on_death():
	get_tree().quit()


func take_damage(val: int):
	stats.take_damage(val)


func move(delta) -> void:
	var velocity_x = Input.get_action_raw_strength("move_right") - Input.get_action_raw_strength("move_left")
	var velocity_y = Input.get_action_raw_strength("move_down") - Input.get_action_raw_strength("move_up")
	
	if Input.is_action_just_pressed('dash'):
		velocity = get_local_mouse_position()
		is_dashing = true
		get_tree().create_timer(dash_duration).timeout.connect(func(): is_dashing = false)
	
	velocity = velocity.normalized()
	
	if is_dashing:
		velocity *= stats.MOVE_SPEED * 2
	else:
		velocity = Vector2(velocity_x, velocity_y) * stats.MOVE_SPEED
	
	move_and_slide()
