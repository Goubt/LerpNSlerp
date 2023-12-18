extends CharacterBody3D

var spd = 25
#var spd = randf_range(20,50)
var amplitude = 5  # Adjust as needed
var frequency = 0.2  # Adjust as needed




func _ready():
	pass

func _physics_process(_delta):
	
	velocity.x = amplitude * sin(frequency * transform.origin.y)
	velocity.z = spd
	move_and_slide()
	
	#remove the enemy when they get behind the player
	if transform.origin.z > 100:
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		body.choosePowerUP()
		queue_free()
