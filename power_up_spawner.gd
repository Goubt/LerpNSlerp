extends Node3D

# Preload the scenes for each type of power-up
var PowerUpHealthScene = load("res://power_up_health.tscn")
var PowerUpRapidFireScene = load("res://power_up_rapid_fire.tscn")

# Preload the script that you want to attach to the power-up instances
var power_up_script = load("res://power_up.gd")

# Define the grid size for power-up spawning
var pupGridSize = Vector2(5, 3)  # Adjust grid size as needed

func _ready():
	# Initialize anything that needs to be set up when the node is ready
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_power_up():
	var power_up_instance
	# Randomly choose the type of power-up to spawn
	if randi() % 2 == 0:
		power_up_instance = PowerUpHealthScene.instantiate()
	else:
		power_up_instance = PowerUpRapidFireScene.instantiate()
	
	add_child(power_up_instance)
	# Set the spawn position of the power-up instance
	power_up_instance.transform.origin = transform.origin + Vector3(randf_range(-5, 5), randf_range(-5, 5), 0)

func _on_timer_timeout():
	if randi_range(1, 10) == 1:
		spawn_power_up()
