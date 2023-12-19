extends Camera3D

var follow_speed = 5.0
var offset = Vector3(0, 5, 20)  # Adjust the offset as needed

# This assumes that the player scene is instanced under a node named 'PlayerInstance' in 'Main'
var ship_model_path = "../Node3D"

func _ready():
	# Update the path if necessary when the scene is ready
	ship_model_path = "../Node3D"

func _process(delta):
	var ship_model = get_node_or_null(ship_model_path)
	if ship_model:
		var target_position = ship_model.global_transform.origin + offset
		# Correct method call to interpolate between vectors
		global_transform.origin = global_transform.origin.lerp(target_position, follow_speed * delta)
