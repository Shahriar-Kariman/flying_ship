extends CharacterBody3D

var active = true

var rotationAngleDegree : float
var rotationSpeedDegree : float
var rotationDirection : float

var motionVelocity : Vector3
var motionSpeedXZ : float
var motionDirectionXZ : int

var motionSpeedY : float
var motionDirectionY : float

func _ready():
	rotationAngleDegree = 0
	rotationSpeedDegree = 14
	rotationDirection = 0
	
	motionVelocity = Vector3.ZERO
	motionSpeedXZ = 64
	motionDirectionXZ = 0
	
	motionSpeedY = 48
	motionDirectionY = 0

func cursor_control():
	var mouse_positionY = get_viewport().get_mouse_position().y
	var maxY = get_viewport().size.y
	var normalized_position = mouse_positionY/maxY
	motionDirectionY = 1-normalized_position*2  #gives a value between -1 and 1

func my_rotate(delta):
	var rotationVelocityDegree = rotationSpeedDegree * rotationDirection
	var rotationAngleRadian = float(rotationAngleDegree/360)*(PI*2)
	if rotationAngleRadian > 2*PI:
		rotationAngleRadian = rotationAngleRadian - (2*PI)
	transform = transform.rotated_local(Vector3.UP, rotationVelocityDegree * delta * rotationAngleRadian)

func my_move(delta):
	var rotationAngleRadian = float(rotationAngleDegree/360)*(PI*2)
	var motionX = sin(rotationAngleRadian)*motionDirectionXZ
	var motionZ = cos(rotationAngleRadian)*motionDirectionXZ
	var motionY = motionDirectionY*motionSpeedY*delta
	
	motionVelocity = Vector3(motionX, motionY, motionZ)
	
	motionVelocity.normalized()
	
	motionVelocity *= motionSpeedXZ
	transform = transform.translated_local(motionVelocity*delta)

func _process(delta):
	if active:
		cursor_control()
		if Input.is_action_pressed("left"):
			rotationAngleDegree = 1
			rotationDirection = 1
		elif Input.is_action_pressed("right"):
			rotationAngleDegree = 1
			rotationDirection = -1
		else:
			rotationAngleDegree = 0
			rotationDirection = 0
		
		if Input.is_action_pressed("forward"):
			motionDirectionXZ = -1
		elif Input.is_action_pressed("backward"):
			motionDirectionXZ = 1
		else:
			motionDirectionXZ = 0
		my_rotate(delta)
		my_move(delta)

func _on_main_pause():
	active = false
