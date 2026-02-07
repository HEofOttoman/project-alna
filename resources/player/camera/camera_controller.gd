extends Node3D
class_name CameraController
### Current Version: V2

@export_category('Camera Controller Settings')
@export_group('Camera Settings')
@export var min_limit_x : float = -0.8 ## Clamp for the lowest the camera can go
@export var max_limit_x : float = -0.2 ## Clamp for the highest the camera can go
@export var horizontal_acceleration : float = 2.0 ## 
@export var vertical_acceleration : float = 2.0 ## 
@export var mouse_acceleration : float = 0.005 ## Value to decrease the magnitude of mouse movement (AKA SENSITIVITY)

@export_group('Camera Variables')
@export_range(0, 1, 0.05) var mouse_sensitivity_range = 0.05 ## To help make it editable via options
@export var camera_rotation : Vector2 = Vector2.ZERO ## For the newer tutorial
@export var max_y_rotation := 1.2

@export var edge_spring_arm : SpringArm3D ## The edge spring arm
@export var rear_spring_arm : SpringArm3D ## The rear spring arp
@export var camera : Camera3D

@export var aim_rear_spring_length : float = 0.8
@export var aim_edge_spring_length : float = 0.5

@export var camera_alignment_speed : float = 0.2
@export var aim_speed : float = 0.4
@export var aim_fov : float = 55

@export var sprint_fov : float = 100
@export var sprint_tween_speed : float = 0.8

@onready var default_edge_springarm_length : float = edge_spring_arm.spring_length
@onready var default_rear_springarm_length : float = rear_spring_arm.spring_length
@onready var default_fov : float = camera.fov 

var camera_tween : Tween

enum CAMERA_ALIGNMENT {
	LEFT = -1,
	CENTRE = 0,
	RIGHT = 1
}
@export var current_camera_alignment = CAMERA_ALIGNMENT.RIGHT

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED ## Oo makes camera good and controllable

## Implementation for controllers
#func _process(delta: float) -> void:
	#var joy_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))



## Keyboard/Mouse implementation
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('ui_cancel'): ## Implemented to show mouse
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	
	if event is InputEventMouseMotion:
		#rotation.y += event.relative.x * 0.005
		#rotate_from_vector(event.relative * mouse_acceleration)
		var mouse_motion : Vector2 = event.screen_relative * mouse_acceleration
		camera_look(mouse_motion)
	
	if event.is_action_pressed('swap_camera_alignment'):
		swap_camera_alignment()
		print('detected f5')
	
	if event.is_action_pressed("aim"):
		enter_aim()
	if event.is_action_released("aim"):
		exit_aim()
	
	#if event.is_action_pressed("run"):
		#enter_sprint()
	#if event.is_action_released("run"):
		#exit_sprint()

func enter_sprint() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = create_tween()
	camera_tween.set_parallel()
	
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	
	camera_tween.tween_property(camera, 'fov', sprint_fov, sprint_tween_speed)
	camera_tween.tween_property(edge_spring_arm, 'spring_length', 
	default_edge_springarm_length * current_camera_alignment, 
	aim_speed)
	camera_tween.tween_property(rear_spring_arm, 'spring_length', 
	default_rear_springarm_length, 
	aim_speed)

func exit_sprint() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = create_tween()
	camera_tween.set_parallel()
	
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	
	camera_tween.tween_property(camera, 'fov', default_fov, sprint_tween_speed)
	camera_tween.tween_property(edge_spring_arm, 'spring_length', 
	default_edge_springarm_length * current_camera_alignment, 
	aim_speed)
	camera_tween.tween_property(rear_spring_arm, 'spring_length', 
	default_rear_springarm_length, 
	aim_speed)

func enter_aim() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = create_tween()
	camera_tween.set_parallel()
	
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	
	camera_tween.tween_property(camera, 'fov', aim_fov, aim_speed)
	camera_tween.tween_property(edge_spring_arm, 'spring_length', 
	aim_edge_spring_length * current_camera_alignment, 
	aim_speed)
	camera_tween.tween_property(rear_spring_arm, 'spring_length', 
	aim_rear_spring_length, 
	aim_speed)
	

func exit_aim() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = create_tween()
	camera_tween.set_parallel()
	
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	
	camera_tween.tween_property(camera, 'fov', default_fov, aim_speed)
	camera_tween.tween_property(edge_spring_arm, 'spring_length', 
	default_edge_springarm_length * current_camera_alignment, 
	aim_speed)
	camera_tween.tween_property(rear_spring_arm, 'spring_length', 
	default_rear_springarm_length, 
	aim_speed)
	

func swap_camera_alignment() -> void:
	match current_camera_alignment:
		CAMERA_ALIGNMENT.LEFT:
			set_current_camera_alignment(CAMERA_ALIGNMENT.RIGHT)
		CAMERA_ALIGNMENT.CENTRE:
			#set_current_camera_alignment(CAMERA_ALIGNMENT.CENTRE)
			return
		CAMERA_ALIGNMENT.RIGHT:
			set_current_camera_alignment(CAMERA_ALIGNMENT.LEFT)
			
	
	#var new_pos : float = -edge_spring_arm.spring_length
	#default_edge_springarm_length = -default_edge_springarm_length
	var new_pos : float = default_edge_springarm_length * current_camera_alignment #--s
	
	set_rear_spring_arm_position(
		#default_edge_springarm_length,
		new_pos,
	 camera_alignment_speed)

func set_current_camera_alignment(alignment: CAMERA_ALIGNMENT) -> void:
	current_camera_alignment = alignment

func set_rear_spring_arm_position(pos: float, speed: float) -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = create_tween()
	camera_tween.tween_property(edge_spring_arm, "spring_length", pos, speed)

### ---  Also based on https://www.youtube.com/watch?v=Ou1PRxxILAk ---
## Based on the newer tutorial (^Above)
func camera_look(mouse_movement):
	camera_rotation += mouse_movement
	
	transform.basis = Basis()
	
	rotate_object_local(Vector3(0,1,0), -camera_rotation.x)
	rotate_object_local(Vector3(1,0,0), -camera_rotation.y)
	
	camera_rotation.y = clamp(camera_rotation.y, -max_y_rotation, max_y_rotation) ## Clamps the movement of the camera
	
	

### ---- Based on the Zelda tutorial ----

## Rotates from a vector
func rotate_from_vector(event_relative_vector: Vector2):
	if event_relative_vector.length() == 0:
		return
	rotation.y += event_relative_vector.x ## Left and right view rotation
	rotation.x += event_relative_vector.y ## Up and down view rotation
	rotation.x = clamp(rotation.x, min_limit_x, max_limit_x) ## Clamps the movement of the camera
	



func _on_sprint_ended() -> void:
	exit_sprint()

func _on_sprint_sprint_started() -> void:
	enter_sprint()
