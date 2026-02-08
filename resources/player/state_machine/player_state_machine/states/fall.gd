extends MotionState

func _update(_delta: float):
	set_direction()
	#calculate_velocity(SPEED, direction, _delta)
	calculate_velocity(speed, direction, PLAYER_MOVEMENT_SETTINGS.in_air_acceleration, _delta)
	calculate_gravity(_delta)
	
	if is_on_floor():
		finished.emit('Idle')
