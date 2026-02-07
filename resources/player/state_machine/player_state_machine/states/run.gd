extends MotionState

func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit('Jump')
	if _event.is_action_pressed("run") and sprint_remaining > 0.5:
		finished.emit('Sprint')

func _update(_delta: float):
	set_direction()
	calculate_velocity(SPEED, direction, _delta)
	replenish_sprint(_delta)
	
	if direction == Vector3.ZERO:
		finished.emit('Idle')
	
	if not is_on_floor():
		finished.emit('Fall')
