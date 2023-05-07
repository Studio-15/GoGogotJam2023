extends Node

@onready var parent: CharacterBody2D = get_parent()
@onready var endTimer: Timer = Timer.new()
@onready var tickTimer: Timer = Timer.new()
@export var tickDuration: float = 1.0
@export var duration: float = 5.0
@export var damage: int = 1



func _ready() -> void:
	endTimer.wait_time = duration
	tickTimer.wait_time = tickDuration

	add_child(endTimer)
	add_child(tickTimer)

	endTimer.timeout.connect(on_end_timer_end)
	endTimer.one_shot = true

	tickTimer.timeout.connect(on_tick_timer_end)

	endTimer.start()
	tickTimer.start()


func on_tick_timer_end():
	parent.take_damage(damage)


func on_end_timer_end():
	queue_free()
