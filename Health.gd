extends Label

func _process(delta):
	self.text = "Health: " + str(Global.playerHealth)
	
