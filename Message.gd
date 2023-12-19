extends Label

@onready var timer = get_node("MessageTimer")

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	self.visible = false


func print_message(message):
	self.text = message
	self.visible = true
	timer.start()
	

func _on_timer_timeout():
	self.visible = false
