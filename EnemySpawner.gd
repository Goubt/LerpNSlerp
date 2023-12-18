extends Node3D


# Reference the main scene
@onready var main = get_tree().current_scene

# Reference the enemy scene
var Enemy = load("res://enemy.tscn")

# Define the grid size for enemy spawning
var enemyGridSize = Vector2(5, 3)  # Adjust grid size as needed

# Define the spacing between enemies in the grid
var enemySpacing = Vector3(4, 4, 0)


var childNodes : Array

var MAX_ENEMIES = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn enemies in a grid pattern
	spawn_enemy_grid()

# Spawn enemies in a grid pattern
func spawn_enemy_grid():
	for i in range(enemyGridSize.x):
		
		var enemy = Enemy.instantiate()
		main.add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(i * enemySpacing.x, randf_range(-10, 10) ,randf_range(3, 3))

func spawn():
	var enemy = Enemy.instantiate()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(randf_range(-15, 15), randf_range(-10, 10), 0)
	
func count_enemies():
	var enemy_count : int = 0
	childNodes = main.get_children()
	
	for i in range(len(childNodes)):
		var child = childNodes[i]
		
		if child.is_in_group("Enemies"):
			enemy_count += 1
			
	#print(enemy_count)
	return enemy_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_timer_timeout():
	if count_enemies() < MAX_ENEMIES:			
		spawn_enemy_grid()

