extends Node2D


var effect_duration: float = 1
var effect_strength: float = 1
@onready var area_2d: Area2D = $Area2D
@onready var cooldown: Timer = $Cooldown
@onready var duration: Timer = $Duration


func _ready() -> void:
	end_effect()
	duration.connect('timeout', end_effect)

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.hit_by_gale_force(effect_duration, effect_strength)


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed('action_shoot') and cooldown.is_stopped():
		area_2d.monitoring = true
		visible = true
		duration.start()
		cooldown.start()


func end_effect():
	area_2d.monitoring = false
	visible = false
