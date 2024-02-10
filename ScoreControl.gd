extends Control

signal win

var numLoops = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if numLoops>2:
		win.emit()

func _on_flying_craft_success():
	numLoops += 1
	$HBoxContainer/Label.text = "%02d" % numLoops
