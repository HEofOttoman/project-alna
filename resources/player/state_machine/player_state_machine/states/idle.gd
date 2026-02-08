extends MotionState

func _state_input(_event: InputEvent) -> void:
	# I come across a strange bug here where pressing escape causes the character to jump..
	
	if _event.is_action_pressed("jump"):
		finished.emit('Jump')
	
	if _event.is_action_pressed('aim'):
		finished.emit('AimIdle')

func _update(_delta: float):
	set_direction()
	#calculate_velocity(SPEED, direction, _delta)
	calculate_velocity(speed, direction, PLAYER_MOVEMENT_SETTINGS.acceleration, _delta)
	replenish_sprint(_delta)
	
	if direction != Vector3.ZERO:
		finished.emit('Run')
	
	if not is_on_floor():
		finished.emit('Fall')
	
