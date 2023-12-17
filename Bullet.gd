extends CharacterBody3D

@onready var main = get_tree().current_scene
@onready var player = main.get_node("Node3D")	

func _physics_process(delta):
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Enemies"):
		player.enemyHit.play()
		Global.score += 1
		body.queue_free()
		queue_free()
		
	
