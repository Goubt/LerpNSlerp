extends CharacterBody3D

enum PowerUpType { RAPID_FIRE, HEALTH }

var model_paths = {
	PowerUpType.RAPID_FIRE: "res://Models/PowerUpRapidFire.gltf",
	PowerUpType.HEALTH: "res://Models/PowerUpHealth.gltf"
}

var spd = 25
#var spd = randf_range(20,50)
var amplitude = 5  # Adjust as needed
var frequency = 0.1  # Adjust as needed
var rotation_speed = 100.0


func _ready():
	randomize()
	var selected_type_index = randi() % PowerUpType.values().size()
	var selected_type = PowerUpType.values()[selected_type_index]
	var model_path = model_paths[selected_type]
	
	print("Loading model from path: ", model_path)
	var model_resource = load(model_path)

	if model_resource:
		print("Model loaded successfully: ", model_resource)
		# Assuming MeshInstance3D is already present in the scene and named exactly "MeshInstance3D".
		var mesh_instance = get_node("MeshInstance3D") as MeshInstance3D
		if mesh_instance:
			mesh_instance.mesh = model_resource as Mesh
			print("Mesh assigned to MeshInstance3D.")
		else:
			print("MeshInstance3D node not found.")
	else:
		print("Failed to load model from path: ", model_path)

func _physics_process(_delta):
	
	velocity.x = amplitude * sin(frequency * transform.origin.y)
	velocity.z = spd
	move_and_slide()
	
	#remove the enemy when they get behind the player
	if transform.origin.z > 100:
		queue_free()

func _on_CharacterBody3D_body_entered(body):
	if body.is_in_group("Player"):
		# Assuming choosePowerUP is a function defined in the player script
		body.choosePowerUP()
		queue_free()  # Remove the power-up from the scene
