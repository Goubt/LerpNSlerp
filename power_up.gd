extends CharacterBody3D

var spd = 25
#var spd = randf_range(20,50)
var amplitude = 5  # Adjust as needed
var frequency = 0.1  # Adjust as needed

var rotation_speed = 100.0  # Degrees per frame, adjust as needed

func _ready():
	pass

func _physics_process(_delta):
	velocity.x = amplitude * sin(frequency * transform.origin.y)
	velocity.z = spd
	move_and_slide()

	# Rotate the model
	rotation_degrees.y += rotation_speed * _delta

	#remove the enemy when they get behind the player
	if transform.origin.z > 100:
		queue_free()

func _on_PowerUp_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.receive_power_up("Health")
		queue_free()  # Remove the power-up after it's picked up
