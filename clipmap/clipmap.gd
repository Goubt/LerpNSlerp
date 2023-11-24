extends Node3D

# Refernce to player 
@export var player_character:Node3D;

func _ready():
	player_character = get_node("player_character.gd")

func _physics_process(delta):
	global_position = player_character.global_position.round() * Vector3(1,0,1);
	
