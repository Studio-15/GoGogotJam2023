extends Node2D


@onready var Damage_numbers: PackedScene = preload('res://Common/HealthBar/damage_numbers.tscn')


func _ready() -> void:
	set_max_health(get_parent().get_node("Stats").HEALTH)


func set_max_health(val: int):
	$ProgressBar.max_value = val
	$ProgressBar.value = val


func set_current_health(val: int):
	var damage_numbers = Damage_numbers.instantiate()
	damage_numbers.set_number($ProgressBar.value - val)
	add_child(damage_numbers)

	var TW = create_tween()
	TW.tween_property($ProgressBar, "value", val, 0.2)
