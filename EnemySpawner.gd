extends Node3D

# Reference the main scene
@onready var main = get_tree().current_scene

# Reference the enemy scene
var Enemy = load("res://enemy.tscn")

# Define the spacing between enemies in the snake
var enemySpacing = Vector3(0, 0, 4)

var childNodes : Array

var MAX_ENEMIES : int

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn enemies in a snake-like pattern
	spawn_snake()
	

# Spawn enemies in a snake-like pattern
func spawn_snake():
	for i in range(5):
		var enemy = Enemy.instantiate()
		main.add_child(enemy)
		enemy.transform.origin = transform.origin + Vector3(0, randf_range(-10, 10), -count_enemies() * enemySpacing.z - i * 5)

func spawn_single():
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

	return enemy_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("Max Enemies: ", MAX_ENEMIES)
	MAX_ENEMIES = 10 + (0.5 * Global.score)
	pass

func _on_timer_timeout():
	if count_enemies() < MAX_ENEMIES:
		spawn_snake()
