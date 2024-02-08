extends Node3D

signal pause

func _ready():
	#DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	pass

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		$PauseControl.visible = true
		#DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
		pause.emit()
