extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/RestartButton.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	Global.score = 0

func _on_quit_button_pressed():
	get_tree().quit()
