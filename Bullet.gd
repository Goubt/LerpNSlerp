extends CharacterBody3D

@onready var enemyHit: AudioStreamPlayer = $enemyHitSound
@onready var main = get_tree().current_scene	

func _physics_process(delta):
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemies"):
		if enemyHit.is_playing():
			# If the sound is already playing, stop it
			enemyHit.stop()
			
		enemyHit.play() 
			
		body.queue_free()
		queue_free()
		
		
