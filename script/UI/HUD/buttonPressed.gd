extends TouchScreenButton

func _physics_process(delta):
	if self.is_pressed():
		self.modulate = "ffffff"
	else:
		self.modulate = "96ffffff"
