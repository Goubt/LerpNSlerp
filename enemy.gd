extends CharacterBody3D

@onready var main = get_tree().current_scene
@onready var player = main.get_node("Node3D")	

var spd = randf_range(20,40)
var amplitude = 5  # Adjust as needed
var frequency = 0.2  # Adjust as needed

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
				Global.playerHealth -= 1
				#print("collided")	
				
	

