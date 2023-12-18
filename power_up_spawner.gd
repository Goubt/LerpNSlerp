extends Node3D

# Reference the main scene
@onready var main = get_tree().current_scene
# Reference the enemy scene
var PowerUp = load("res://power_up.tscn")
# Define the grid size for enemy spawning
var pupGridSize = Vector2(5, 3)  # Adjust grid size as needed

@onready var pup_timer : Timer = get_node("PUP_Timer")


var power : String
var powerList : Array = ["RapidFire"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pup_timer.timeout.connect(_on_pup_timer_timeout)
	pass

func spawn():
	#print("spawned")
	playerCollision()
	var pup = PowerUp.instantiate()
	self.add_child(pup)
	#pup.transform.origin = transform.origin + Vector3(0,0,0)
	pup.transform.origin = transform.origin + Vector3(randf_range(-15, 15), randf_range(-10, 10), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func playerCollision():
	var childNodes = get_children(false)
	for i in range(len(childNodes)):
		if (str(childNodes[i].get_class()) == "CharacterBody3D"):
			var child = childNodes[i]
			for index in range(child.get_slide_collision_count()):
				var collision = child.get_slide_collision(index)
				if collision.get_collider() != null:
					if collision.get_collider().is_in_group("Player"):
						#print("collided with player")
						child.queue_free()
						selectPowerUP()
						
						
func selectPowerUP():
	power =  powerList[randi_range(0, len(powerList) -1)]
	pup_timer.start()
	Global.set(power, true)
	#print(Global.RapidFire)

func _on_timer_timeout():
	if randi_range(1, 10) == 1:
		spawn()
		
func _on_pup_timer_timeout():
	Global.set(power, false)
	#print(Global.RapidFire)
