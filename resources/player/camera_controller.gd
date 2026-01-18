extends Node3D

@export var min_limit_x : float = -0.8 ## Clamp for the lowest the camera can go
@export var max_limit_x : float = -0.2 ## Clamp for the highest the camera can go
@export var horizontal_acceleration : float = 2.0 ## 
@export var vertical_acceleration : float = 2.0 ## 
@export var mouse_acceleration : float = 0.005 ## Value to decrease the magnitude of mouse movement

## Implementation for controllers
#func _process(delta: float) -> void:
	#var joy_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))

## Keyboard/Mouse implementation
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotation.y += event.relative.x * 0.005
		rotate_from_vector(event.relative * mouse_acceleration)

func rotate_from_vector(event_relative_vector: Vector2):
	if event_relative_vector.length() == 0:
		return
	rotation.y += event_relative_vector.x ## Left and right view rotation
	rotation.x += event_relative_vector.y ## Up and down view rotation
	rotation.x = clamp(rotation.x, min_limit_x, max_limit_x) ## Clamps the movement of the camera
	

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
