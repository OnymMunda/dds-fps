extends Area3D

var Explosion = preload("res://explosion.tscn")

@export var speed: float = 100

@onready var mesh = $Bullet
@onready var collision = $CollisionShape3D
@onready var timer = $Timer

func _ready() -> void:
	timer.start()
	
func _process(delta):
	position -= transform.basis * Vector3(0,0,speed) * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	collide(area)
	

func _on_body_entered(body: Node3D) -> void:
	collide(body)
	
	if body.has_method("take_damage"):
		body.take_damage(1)
		
		var explosion = Explosion.instantiate()
		get_tree().current_scene.add_child(explosion)
		
		explosion.scale = Vector3(0.1, 0.1, 0.1)
		explosion.get_node("GPUParticles3D").amount = 6
		explosion.global_position = body.global_position
		explosion.global_rotation = Vector3.ZERO
		explosion.get_node("GPUParticles3D").restart()
	
func collide(collider):
	collision.disabled = true
	mesh.hide()
	collision.hide()

	
