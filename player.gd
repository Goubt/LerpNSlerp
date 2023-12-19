extends CharacterBody3D

@onready var shootSound: AudioStreamPlayer = $ShootSound
@onready var enemyHit: AudioStreamPlayer = $enemyHitSound

const MAXSPEED = 30
const ACCELERATION = 0.75
var inputVector = Vector3()

var can_fire = true

@onready var guns = [$Gun1, $Gun2]
@onready var main = get_tree().current_scene
var Bullet = load("res://bullet.tscn")

@onready var bullet_interval = get_node("BulletInterval")
@onready var pup_timer : Timer = get_node("PUP_Timer")

@onready var third_person_camera = get_node("/root/Main/ThirdPersonCam")
@onready var first_person_camera = $FirstPersonCam

var power : String
var powerList : Array = ["RapidFire", "Health"]
const HEALTH_POWERUP_AMOUNT = 1  # The amount of health to restore
const MAX_HEALTH = 100  # Maximum health

func _physics_process(delta):
	transform.origin.z = 0
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
<<<<<<< Updated upstream
	transform.origin.x = clamp(transform.origin.x, -20, 20)
	transform.origin.y = clamp(transform.origin.y, -10, 10)
=======
	transform.origin.x = clamp(transform.origin.x, -200, 200)
	transform.origin.y = clamp(transform.origin.y, -100, 100)
>>>>>>> Stashed changes
	
	if Input.is_action_pressed("ui_accept") and can_fire:
		shoot()
		#Start interval timer
		if not Global.RapidFire:
			can_fire = false
			bullet_interval.start()

func _ready():
	bullet_interval.timeout.connect(_on_timer_timeout)
	pup_timer.timeout.connect(_on_pup_timer_timeout)
	
func _on_timer_timeout():
	can_fire = true
	
func shoot():
	shootSound.play()
	for i in guns:
		var bullet = Bullet.instantiate()
		main.add_child(bullet)
		bullet.transform = i.global_transform
		bullet.velocity = bullet.transform.basis.z * -100
		
func receive_power_up(type: String):
	match type:
		"RapidFire":
			activate_rapid_fire()
		"Health":
			increase_health()

func activate_rapid_fire():
	# Activate the rapid fire ability
	Global.RapidFire = true
	# Start the timer to deactivate the power-up after some time
	pup_timer.start()

func increase_health():
	# Increase the player's health
	Global.playerHealth = min(Global.playerHealth + HEALTH_POWERUP_AMOUNT, MAX_HEALTH)

func _on_pup_timer_timeout():
	# Deactivate the rapid fire ability when the timer runs out
	if Global.RapidFire:
		Global.RapidFire = false
		
		
# Reference to the cameras
func _process(delta):
	if Input.is_action_just_pressed("switch_camera"):
		switch_camera()

func switch_camera():
	if third_person_camera.is_current():
		first_person_camera.make_current()
	else:
		third_person_camera.make_current()
