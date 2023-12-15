extends Node3D


# Called when the node enters the scene tree for the first time.
@onready var main = get_tree().current_scene
var Enemy = load("res://enemy.tscn")

func spawn():
	var enemy = Enemy.instantiate()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(randf_range(-15, 15), randf_range(-10, 10), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	spawn()
