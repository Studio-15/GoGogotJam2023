extends Node2D


var spriteReady = load('res://Abilities/SpikeTrap/Spiketrap 1.png')
var spriteActive = load('res://Abilities/SpikeTrap/Spiketrap 2.png')
var damage = 5


func _on_area_2d_body_entered(body: Node2D) -> void:
	$Sprite2D.texture = spriteActive
	
	$Retract.start()
	
	body.take_damage(damage)


func _on_retract_timeout() -> void:
	$Sprite2D.texture = spriteReady


