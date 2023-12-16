extends CharacterBody3D

var spd = randf_range(20,50)
var amplitude = 5  # Adjust as needed
var frequency = 0.2  # Adjust as needed

func _physics_process(delta):
	velocity.x = amplitude * sin(frequency * transform.origin.y)
	velocity.z = spd

	move_and_slide()
	
	#remove the enemy when they get behind the player
	if transform.origin.z > 10:
		queue_free()
	
