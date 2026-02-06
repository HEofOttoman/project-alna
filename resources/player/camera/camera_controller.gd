extends Node3D
class_name CameraController
### Current Version: V2

@export_group('Camera Settings')
@export var min_limit_x : float = -0.8 ## Clamp for the lowest the camera can go
@export var max_limit_x : float = -0.2 ## Clamp for the highest the camera can go
@export var horizontal_acceleration : float = 2.0 ## 
@export var vertical_acceleration : float = 2.0 ## 
@export var mouse_acceleration : float = 0.005 ## Value to decrease the magnitude of mouse movement (AKA SENSITIVITY)

@export_range(0, 1, 0.05) var mouse_sensitivity_range = 0.05 ## To help make it editable via options
@export var camera_rotation : Vector2 = Vector2.ZERO ## For the newer tutorial
@export var max_y_rotation := 1.2

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
	
