extends CharacterBody3D

var spd = 100
#var spd = randf_range(20,50)
var amplitude = 5  # Adjust as needed
var frequency = 0.2  # Adjust as needed

var powerList : Array = ["RapidFire"]
var power : String

@onready var pup_timer = get_node("Power-UP-Timer")

func _ready():
	pup_timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta):
			
	playerCollision()
	
	velocity.x = amplitude * sin(frequency * transform.origin.y)
	velocity.z = spd
	move_and_slide()
	
	#remove the enemy when they get behind the player
	if transform.origin.z > 10:
		queue_free()

func playerCollision():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() != null:
			if collision.get_collider().is_in_group("Player"):
				queue_free()
				
				#print("collided")	
				
				#print(randi_range(0, len(powerList)))
				power =  powerList[randi_range(0, len(powerList) -1)]
				print(power)
				Global.set(power, true)


func _on_timer_timeout():
	print(power)
	Global.set(power, false)
