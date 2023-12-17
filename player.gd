extends CharacterBody3D

@onready var shootSound: AudioStreamPlayer = $ShootSound
@onready var enemyHit: AudioStreamPlayer = $enemyHitSound

const MAXSPEED = 30
const ACCELERATION = 0.75
var inputVector = Vector3()

@onready var guns = [$Gun1, $Gun2]
@onready var main = get_tree().current_scene

var Bullet = load("res://bullet.tscn")
func _physics_process(delta):
	
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	
	velocity.x = move_toward(velocity.x, inputVector.x * MAXSPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, inputVector.y * MAXSPEED, ACCELERATION)
	
	# Set rotation for floaty spacey feel
	rotation_degrees.z = velocity.x * -2
	rotation_degrees.x = velocity.y / 2
	rotation_degrees.y = -velocity.x /2
	
	move_and_slide()
	
	#Restrict player to window
	transform.origin.x = clamp(transform.origin.x, -20, 20)
	transform.origin.y = clamp(transform.origin.y, -10, 10)
	
	#Pew Pew
	if Input.is_action_just_pressed("ui_accept"):
		shootSound.play()
		for i in guns:
			var bullet = Bullet.instantiate()
			main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velocity = bullet.transform.basis.z * -100
