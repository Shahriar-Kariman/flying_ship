extends CharacterBody3D

signal success
signal lose
signal lose_by_ground

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
	rotationSpeedDegree = 32
	rotationDirection = 0
	
	motionVelocity = Vector3.ZERO
	motionSpeedXZ = 100
	motionDirectionXZ = 0
	
	motionSpeedY = 64
	motionDirectionY = 0

func cursor_control():
	var mouse_positionY = get_viewport().get_mouse_position().y
	var mouse_positionX = get_viewport().get_mouse_position().x
	var maxY = get_viewport().size.y
	var maxX = get_viewport().size.x
	var normalized_positionY = mouse_positionY/maxY
	motionDirectionY = 1-normalized_positionY*2  #gives a value between -1 and 1
	var normalized_positionX = mouse_positionX/maxX
	rotationDirection = 1-normalized_positionX*2

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
		rotationAngleDegree = 1
		cursor_control()
		#if Input.is_action_pressed("left"):
			#rotationAngleDegree = 1
			#rotationDirection = 1
		#elif Input.is_action_pressed("right"):
			#rotationAngleDegree = 1
			#rotationDirection = -1
		#else:
			#rotationAngleDegree = 0
			#rotationDirection = 0
		motionDirectionXZ = -1 #so it moves forward constantly
		#if Input.is_action_pressed("forward"):
			#motionDirectionXZ = -1
		#elif Input.is_action_pressed("backward"):
			#motionDirectionXZ = 1
		#else:
			#motionDirectionXZ = 0
		my_rotate(delta)
		my_move(delta)
		move_and_slide()
		handelCollision()

func handelCollision():
	for index in range (get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider() == null:
			continue
		if collision.get_collider().is_in_group("inside"):
			var loop = collision.get_collider()
			success.emit()
			loop.queue_free()
		elif collision.get_collider().is_in_group("outside"):
			active = false
			lose.emit()
		elif collision.get_collider().is_in_group("ground"):
			active = false
			lose_by_ground.emit()
		else:
			continue
		break # prevent further duplicate calls?

func _on_main_pause():
	active = false

func _on_score_control_win():
	active = false
