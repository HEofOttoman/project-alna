extends StateMachine

@export var player_movement_settings: MovementSettings
@export var character_skin: Node3D


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child: MotionState in get_children():
		child.animation_state_changed.connect(character_skin._on_state_machine_animation_state_changed)
	# Replace with function body.
	return super._ready()


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#marcus
