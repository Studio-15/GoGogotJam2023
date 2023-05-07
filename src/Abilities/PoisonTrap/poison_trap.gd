extends Node2D

@onready var timeoutTimer: Timer = Timer.new()
@onready var poison_prefab = load("res://Abilities/Afflictions/Poison/poison.tscn")

@export var duration: float = 20.0
@export var poison_damage: int = 1
@export var poison_ticks: int = 5
@export var trap_durability: int = 3



func _ready() -> void:
	timeoutTimer.wait_time = duration
	add_child(timeoutTimer)
	timeoutTimer.timeout.connect(on_timeout_timer_end)
	timeoutTimer.start()

func on_timeout_timer_end():
	queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("Enemy"):
		var poison_instance = poison_prefab.instantiate()
		poison_instance.duration = poison_ticks
		poison_instance.damage = poison_damage
		body.add_child(poison_instance)
		trap_durability -= 1
		if trap_durability < 1:
			queue_free()
