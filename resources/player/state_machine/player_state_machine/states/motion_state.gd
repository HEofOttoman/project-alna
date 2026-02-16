extends State
class_name MotionState

### Based on the tutorial https://www.youtube.com/watch?v=NQUSSaStv8g

var speed : float
var sprint_speed : float
var aiming_speed : float
var jump_velocity : float
var jump_gravity : float
var fall_gravity : float

static var input_dir : Vector2 = Vector2.ZERO
static var direction : Vector3 = Vector3.ZERO
static var velocity : Vector3 = Vector3.ZERO
static var sprint_remaining := 0.0

## Disabled after adding movement_stats resource
#const SPRINT_SPEED := 11.0
#const SPEED := 7.0
#const AIMING_SPEED := 5.0
#
#const JUMP_VELOCITY := 4.5
#const GRAVITY := -9.8
#const ACCELERATION := 1000
#const SPRINT_DURATION := 7.7

const PLAYER_MOVEMENT_SETTINGS = preload("res://resources/player/player_movement_settings.tres")

signal velocity_updated(vel: Vector3)
signal animation_state_changed(state: String)

func _ready() -> void:
	#sprint_remaining = SPRINT_DURATION
	sprint_remaining = PLAYER_MOVEMENT_SETTINGS.sprint_duration
	velocity_updated.connect(owner.set_velocity_from_motion)
	
	
	speed = PLAYER_MOVEMENT_SETTINGS.get_velocity(PLAYER_MOVEMENT_SETTINGS.jump_distance, 
		PLAYER_MOVEMENT_SETTINGS.time_to_jump_apex + PLAYER_MOVEMENT_SETTINGS.time_to_land) #* 1.5
	
	sprint_speed = PLAYER_MOVEMENT_SETTINGS.get_velocity(PLAYER_MOVEMENT_SETTINGS.sprint_jump_distance, 
		PLAYER_MOVEMENT_SETTINGS.time_to_jump_apex + PLAYER_MOVEMENT_SETTINGS.time_to_land) #* 1.7
	
	aiming_speed = PLAYER_MOVEMENT_SETTINGS.get_velocity(PLAYER_MOVEMENT_SETTINGS.aim_jump_distance, 
		PLAYER_MOVEMENT_SETTINGS.time_to_jump_apex + PLAYER_MOVEMENT_SETTINGS.time_to_land)
	
	fall_gravity = PLAYER_MOVEMENT_SETTINGS.get_fall_gravity()
	jump_gravity = PLAYER_MOVEMENT_SETTINGS.get_jump_gravity()
	
	jump_velocity = PLAYER_MOVEMENT_SETTINGS.get_jump_velocity(jump_gravity)
	#print(speed) # used to learn the speed

func set_direction() -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").rotated(-owner.camera.global_rotation.y) ##
	direction = (owner.global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	
#func calculate_velocity(_speed: float, _direction: Vector3, delta: float) -> void:
func calculate_velocity(_speed: float, _direction: Vector3, acceleration: float, delta: float) -> void:
	velocity.x = move_toward(velocity.x, _direction.x * _speed, acceleration*delta)
	velocity.z = move_toward(velocity.z, _direction.z * _speed, acceleration*delta)
	velocity_updated.emit(velocity)
	

func calculate_gravity(delta: float) -> void:
	if not owner.is_on_floor():
		#velocity.y += GRAVITY * delta
		if velocity.y > 0: # Compares to be either fall or jump gravity
			velocity.y -= jump_gravity * delta
		else:
			velocity.y -= fall_gravity * delta
		

func is_on_floor() -> bool:
	return owner.is_on_floor()

func replenish_sprint(delta: float) -> void:
	#sprint_remaining = min(sprint_remaining+delta, SPRINT_DURATION)
	sprint_remaining = min(sprint_remaining+delta, PLAYER_MOVEMENT_SETTINGS.sprint_duration)
	#print('SPRINT REMAINING: ', sprint_remaining)
