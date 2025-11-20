extends CharacterBody3D

var Explosion = preload("res://explosion.tscn")

@export var max_health := 5
var health := 5

func _ready():
	health = max_health

func take_damage(amount := 1):
	health -= amount

	if health <= 0:
		die()

func die():
	var explosion = Explosion.instantiate()
	explosion.global_transform = global_transform
	get_tree().current_scene.add_child(explosion)
	explosion.get_node("GPUParticles3D").restart()
	queue_free()
