extends Control

var text = ""

func _ready():
	pass

func _process(_delta):
	$VBoxContainer/text.text = text

func _on_flying_craft_lose():
	text = "If your father was as good at f#&%ing as you are at flying this thing you would have never been born."

func _on_flying_craft_lose_by_ground():
	text = "You had literally one job. NOT CRASH"

func _on_score_control_win():
	text = "Congrats you win. Why are you still here? you want a medal or somthing?"

func _on_button_button_down():
	get_tree().reload_current_scene()

func _on_end_button_down():
	get_tree().quit()
