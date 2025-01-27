extends CharacterBody3D

#speed
@export var speed = 14
#gravity
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

func _physics_process(delta):
	#local variable to store input direction
	var direction = Vector3.ZERO
	
	#check for inpu to update direction
	if Input.is_action_pressed("moveRight"):
		direction.x += 1
	if Input.is_action_pressed("moveLeft"):
		direction.x -= 1
	if Input.is_action_pressed("moveBack"):
		direction.z += 1
	if Input.is_action_pressed("moveForward"):
		direction.z -= 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
	#Ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	#Gravity
	#Verical velocity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	#moving the character
	velocity = target_velocity
	move_and_slide()
	
