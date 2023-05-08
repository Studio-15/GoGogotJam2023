extends Trap


var spriteReady: CompressedTexture2D = load('res://Abilities/SpikeTrap/Spiketrap 1.png')
var spriteActive: CompressedTexture2D = load('res://Abilities/SpikeTrap/Spiketrap 2.png')
@onready var attack_cooldown: Timer = $AttackCooldown


func _ready() -> void:
	attack_cooldown.wait_time = cooldown_after_setup
	attack_cooldown.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_ready:
		attack(body)


func attack(enemy):
	$Sprite2D.texture = spriteActive
	$RetractCooldown.start()
	enemy.take_damage(damage)
	is_ready = false


func _on_attack_cooldown_timeout() -> void:
	is_ready = true
	attack_cooldown.wait_time = cooldown

	var enemies_in_attack_zone = $Area2D.get_overlapping_bodies()

	for enemy in enemies_in_attack_zone:
		attack(enemy)


func _on_retract_cooldown_timeout() -> void:
	attack_cooldown.start()
	$Sprite2D.texture = spriteReady
