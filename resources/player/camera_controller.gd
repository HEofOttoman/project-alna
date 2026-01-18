extends Node3D

@export var horizontal_acceleration : float = 0.2
@export var vertical_acceleration : float = 0.2

## Implementation for controllers
func _process(delta: float) -> void:
	var joy_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	rotate_from_vector(joy_dir * delta * Vector2(horizontal_acceleration, vertical_acceleration))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotation.y += event.relative.x * 0.005
		rotate_from_vector(event.relative)

func rotate_from_vector(event_relative_vector: Vector2):
	if event_relative_vector.length() == 0:
		return
	rotation.y += event_relative_vector.x * 0.005
	rotation.x += event_relative_vector.y * 0.0005
	rotation.x = clamp(rotation.x, -0.1, 0.1)
	

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
