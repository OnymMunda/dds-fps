extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var screen_center: Vector2

@onready var camera = $CameraSystem/EdgeSpringArm/RearSpringArm/Camera3D
@onready var model = $Model
@onready var animation_player = $Model/AnimationPlayer
@onready var crosshair = $CameraSystem/EdgeSpringArm/RearSpringArm/Camera3D/Sprite2D
@onready var pistol = $Pistol

func _ready() -> void:
	screen_center = get_viewport().get_visible_rect().size/2
	crosshair.position = screen_center

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _process(delta: float) -> void:
	pistol.rotation.x = camera.global_rotation.x
