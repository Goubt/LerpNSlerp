extends CharacterBody3D

const MAXSPEED = 30
const ACCELERATION = 0.75
var inputVector = Vector3()

func _physics_process(delta):
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	
	velocity.x = move_toward(velocity.x, inputVector.x * MAXSPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, inputVector.y * MAXSPEED, ACCELERATION)
	
	rotation_degrees.z = velocity.x * -2
	rotation_degrees.x = velocity.y / 2
	rotation_degrees.y = -velocity.x /2
	
	move_and_slide()
	
	#Restrict player to window
	transform.origin.x = clamp(transform.origin.x, -15, 15)
	transform.origin.y = clamp(transform.origin.y, -10, 10)
