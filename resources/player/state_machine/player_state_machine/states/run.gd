extends MotionState

func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit('Jump')
	#if _event.is_action_pressed("run") and sprint_remaining > 0.5:
	if _event.is_action_pressed("run") and sprint_remaining > PLAYER_MOVEMENT_SETTINGS.minimum_sprint_threshold:
		finished.emit('Sprint')
	
	if _event.is_action_pressed('aim'):
		finished.emit('AimRun')

func _update(_delta: float):
	set_direction()
	#calculate_velocity(SPEED, direction, _delta)
	calculate_velocity(speed, direction, PLAYER_MOVEMENT_SETTINGS.acceleration, _delta)
	replenish_sprint(_delta)
	
	if direction == Vector3.ZERO:
		finished.emit('Idle')
	
	if not is_on_floor():
		finished.emit('Fall')
