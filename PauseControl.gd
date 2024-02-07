extends Control

func _ready():
	pass

func _process(delta):
	pass

func _on_resume_button_down():
	pass # I will implement this later

func _on_exit_button_down():
	get_tree().quit()

func _on_restart_button_down():
	get_tree().reload_current_scene()
