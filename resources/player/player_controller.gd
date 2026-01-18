extends CharacterBody3D

@export_category("Movement")

@export_group("Jump Settings")
@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

#@export var jump_velocity : float = 4.5

@export_group("Movement Settings")
@export var base_speed : float = 4.0

var movement_input : Vector2 = Vector2.ZERO

#@export var camera : Node3D
@onready var camera: Node3D = $CameraController/Camera3D

func _physics_process(delta: float) -> void:
	## Up is forward, down is back
	#movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").rotated(-camera.global_rotation.y)
	velocity = Vector3(movement_input.x, 0, movement_input.y) * base_speed
	
	jump_logic(delta)
	
	### ui_accept is current jump action
	#if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		#velocity.y = -jump_velocity
	#var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	#velocity.y -= gravity * delta
	
	move_and_slide()
	

func jump_logic(delta) -> void:
	if is_on_floor():
		## ui_accept is current jump action
		if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
			velocity.y = -jump_velocity
		var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
		velocity.y -= gravity * delta
		
		move_and_slide()
	else:
		pass


## Template
#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
