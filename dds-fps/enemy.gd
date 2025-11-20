extends CharacterBody3D

@export var max_health := 5
var health := 5

func _ready():
	health = max_health

func take_damage(amount := 1):
	health -= amount

	if health <= 0:
		die()

func die():
	queue_free()
