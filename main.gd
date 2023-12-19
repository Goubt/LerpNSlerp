extends Node3D

var interface : XRInterface
# Called when the node enters the scene tree for the first time.
func _ready():
	interface = XRServer.find_interface("OpenXR")
	if interface and interface.is_initialised():
		print(" Vr is on")
		get_viewport().use_xr = true
