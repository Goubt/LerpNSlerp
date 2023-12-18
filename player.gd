extends CharacterBody3D

@onready var shootSound: AudioStreamPlayer = $ShootSound
@onready var enemyHit: AudioStreamPlayer = $enemyHitSound

const MAXSPEED = 30
const ACCELERATION = 0.75
var inputVector = Vector3()

var can_fire = true

@onready var guns = [$Gun1, $Gun2]
@onready var main = get_tree().current_scene

@onready var bullet_interval = get_node("BulletInterval")

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
	
	
	if Input.is_action_pressed("ui_accept") and can_fire:
		shoot()
		#Start interval timer
		if Global.RapidFire == false:
			can_fire = false
			bullet_interval.start()
		

func _ready():
	bullet_interval.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout():
	can_fire = true
	
func shoot():
	shootSound.play()
	for i in guns:
		var bullet = Bullet.instantiate()
		main.add_child(bullet)
		bullet.transform = i.global_transform
		bullet.velocity = bullet.transform.basis.z * -100


