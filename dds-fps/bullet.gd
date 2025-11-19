extends RigidBody3D

@export var speed: float = 20.0

@onready var mesh = $Bullet
@onready var collision = $CollisionShape3D
@onready var timer = $Timer

func _ready() -> void:
	timer.start()
	
func _process(delta):
	position -= transform.basis * Vector3(0,0,speed) * delta


func _on_timer_timeout() -> void:
	queue_free()
