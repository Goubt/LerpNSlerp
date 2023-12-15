extends CharacterBody3D

var spd = randf_range(20,50)

func _physics_process(delta):
	# Apply the desired speed to the velocity
	velocity.x = 0
	velocity.y = 0
	velocity.z = spd

	move_and_slide()
	
	if transform.origin.z > 10:
		queue_free
	
