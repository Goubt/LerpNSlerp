extends Node3D

# Reference the main scene
@onready var main = get_tree().current_scene

# Reference the enemy scene
var PowerUp = load("res://power_up.tscn")
# Define the grid size for enemy spawning
var pupGridSize = Vector2(5, 3)  # Adjust grid size as needed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	#print("spawned")
	#playerCollision()
	var pup = PowerUp.instantiate()
	self.add_child(pup)
	#pup.transform.origin = transform.origin + Vector3(0,0,0)
	pup.transform.origin = transform.origin + Vector3(randf_range(-5, 5), randf_range(-5, 5), 0)

func _on_timer_timeout():
	if randi_range(1, 10) == 1:
		spawn()
		

