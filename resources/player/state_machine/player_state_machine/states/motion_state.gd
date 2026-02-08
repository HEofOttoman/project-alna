extends State
class_name MotionState

### Based on the tutorial https://www.youtube.com/watch?v=NQUSSaStv8g

static var input_dir : Vector2 = Vector2.ZERO
static var direction : Vector3 = Vector3.ZERO
static var velocity : Vector3 = Vector3.ZERO
static var  sprint_remaining := 0.0

const SPRINT_SPEED := 11.0
const SPEED := 7.0
const AIMING_SPEED := 5.0

const JUMP_VELOCITY := 4.5
const GRAVITY := -9.8
const ACCELERATION := 1000
const SPRINT_DURATION := 7.7

signal velocity_updated(vel: Vector3)

func _ready() -> void:
	sprint_remaining = SPRINT_DURATION
	velocity_updated.connect(owner.set_velocity_from_motion)

func set_direction() -> void:
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").rotated(-owner.camera.global_rotation.y) ##
	direction = (owner.global_transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	

func calculate_velocity(_speed: float, _direction: Vector3, delta: float) -> void:
	velocity.x = move_toward(velocity.x, _direction.x * _speed, ACCELERATION*delta)
	velocity.z = move_toward(velocity.z, _direction.z * _speed, ACCELERATION*delta)
	velocity_updated.emit(velocity)
	

func calculate_gravity(delta: float) -> void:
	if not owner.is_on_floor():
		velocity.y += GRAVITY * delta

func is_on_floor() -> bool:
	return owner.is_on_floor()

func replenish_sprint(delta: float) -> void:
	sprint_remaining = min(sprint_remaining+delta, SPRINT_DURATION)
	#print('SPRINT REMAINING: ', sprint_remaining)
