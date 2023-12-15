extends CharacterBody3D

var spd = randf_range(20,50)

func _physics_process(delta):
	
	# Apply the speed to z axis to move enemy forward
	velocity.x = 0
	velocity.y = 0
	velocity.z = spd

	move_and_slide()
	
	#remove the enemy when they get behind the player
	if transform.origin.z > 10:
		queue_free
	
