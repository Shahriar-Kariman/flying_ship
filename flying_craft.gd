extends CharacterBody3D

var active = true

var rotationAngleDegree : float
var rotationSpeedDegree : float
var rotationDirection : float

var motionVelocity : Vector3
var motionSpeedXZ : float
var motionDirectionXZ : int

func _ready():
	rotationAngleDegree = 0
	rotationSpeedDegree = 12
	rotationDirection = 0
	
	motionVelocity = Vector3.ZERO
	motionSpeedXZ = 50
	motionDirectionXZ = 0

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
	
	motionVelocity = Vector3(motionX, 0, motionZ)
	
	motionVelocity.normalized()
	
	motionVelocity *= motionSpeedXZ
	transform = transform.translated_local(motionVelocity*delta)
	
	#rotationDirection = 0
	#motionDirectionXZ = 0

func _process(delta):
	if active:
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
