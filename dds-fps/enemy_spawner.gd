extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_points: Array[Node3D]
@export var area_size := Vector3(20, 0, 20)
@export var spawn_height := 5.0

func _ready():
	for point in spawn_points:
		var enemy = enemy_scene.instantiate()
		add_child(enemy)  
		enemy.global_position = point.global_position


func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	add_child(enemy) 

	var rand_x = randf_range(-area_size.x / 2, area_size.x / 2)
	var rand_z = randf_range(-area_size.z / 2, area_size.z / 2)

	var spawn_pos = global_transform.origin + Vector3(rand_x, spawn_height, rand_z)
	enemy.global_position = spawn_pos

func _on_timer_timeout() -> void:
	spawn_enemy()
