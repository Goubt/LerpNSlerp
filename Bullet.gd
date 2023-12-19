extends CharacterBody3D

@onready var main = get_tree().current_scene
@onready var player = main.get_node("Node3D")	
@onready var ExplosionParticles = load("res://explosion_particles.tscn")

func _physics_process(delta):
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemies"):
		var particles = ExplosionParticles.instantiate()
		main.add_child(particles)
		particles.transform.origin = transform.origin
		player.enemyHit.play()
		Global.score += 1000
		
		body.queue_free()
		queue_free()
		
	
