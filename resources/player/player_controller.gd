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
@export var run_speed : float = 6.0
@export var speed_while_aiming : float = 2.0

#@export var camera : Node3D
@onready var camera: Node3D = $CameraController/Camera3D
@onready var character_skin: Node3D = $"alna-Main_Character" ## Aka character model

var movement_input : Vector2 = Vector2.ZERO
var aim_up: bool = false: ## Use with the model script (possibly incorrect :I)
	set(value): ## 
		if not aim_up and value:
			character_skin.aim(true)
		if not aim_up and not value:
			character_skin.aim(false)
		aim_up = value
var weapon_active : bool = false


func _physics_process(delta: float) -> void:
	## Up is forward, down is back
	#movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").rotated(-camera.global_rotation.y)
	#var velocity_2d = Vector2(velocity.x, velocity.z)
	#velocity = Vector3(movement_input.x, 0, movement_input.y) * base_speed
	movement_logic(delta)
	jump_logic(delta)
	ability_logic()
	### ui_accept is current jump action
	#if Input.is_action_just_pressed("ui_accept"): #and is_on_floor():
		#velocity.y = -jump_velocity
	#var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	#velocity.y -= gravity * delta
	
	move_and_slide()

## Handles Jumping
func jump_logic(delta) -> void:
	if is_on_floor():
		## ui_accept is current jump action
		if Input.is_action_just_pressed("jump"): #and is_on_floor():
			velocity.y = -jump_velocity
			
	else: ## Plays an animation after player gets off the floor
		#character_skin.set_movement_state('Roll') ## I should make a dedicated jump animation, is roll for now
		character_skin.set_movement_state('Jump') ## I should make a dedicated jump animation, is roll for now
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta

## Controls
func movement_logic(delta) -> void:
	## Up is forward, down is back
	movement_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").rotated(-camera.global_rotation.y)
	var velocity_2d = Vector2(velocity.x, velocity.z) ## Velocity used to not get jump snapping
	var is_running : bool = Input.is_action_pressed("run")
	
	if movement_input != Vector2.ZERO: ## Normal walking
		var movement_speed = run_speed if is_running == true else base_speed ## Accounts for if running
		movement_speed = speed_while_aiming if aim_up else movement_speed
		
		velocity_2d += movement_input * movement_speed * delta
		velocity_2d = velocity_2d.limit_length(movement_speed)
		velocity.x = velocity_2d.x
		velocity.z = velocity_2d.y
		#if is_running == true:
			#$"alna-Main_Character/AnimationPlayer".current_animation = 'Run'
		#else:
			#$"alna-Main_Character/AnimationPlayer".current_animation = 'Walk'
		$"alna-Main_Character".set_movement_state('Run') ## Whatever run is better animation for the speed anyway
		var target_angle = -movement_input.angle() + PI / 2 ## Gets rotation of the camera
		#$"alna-Main_Character".rotation.y = target_angle ## Rotates model based on the rotation of the camera
		$"alna-Main_Character".rotation.y = rotate_toward($"alna-Main_Character".rotation.y, target_angle, 6.0 * delta) 
		## ^Rotates model based on the rotation of the camera (gradually)
		
		
	else: ## Stops you from sliding endlessly
		velocity_2d = velocity_2d.move_toward(Vector2.ZERO, base_speed * 4.0 * delta)
		velocity.x = velocity_2d.x
		velocity.z = velocity_2d.y
		$"alna-Main_Character".set_movement_state('Idle')

func ability_logic() -> void:
	## Melee attack(s)
	if Input.is_action_just_pressed("attack"):
		character_skin.animate_attack()
	
	## Meant to be aiming the gun
	aim_up = Input.is_action_pressed("aim")
	
	if Input.is_action_just_pressed("switch_weapon") and character_skin.is_attacking == false:
		weapon_active = not weapon_active
		character_skin.switch_weapon(weapon_active)
	

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
