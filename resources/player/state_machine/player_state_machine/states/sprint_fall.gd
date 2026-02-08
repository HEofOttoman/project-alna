extends MotionState

signal sprint_ended

func _update(_delta: float):
	#calculate_velocity(SPRINT_SPEED, direction, _delta)
	set_direction()
	calculate_velocity(sprint_speed, direction, PLAYER_MOVEMENT_SETTINGS.in_air_acceleration, _delta)
	calculate_gravity(_delta)
	
	if is_on_floor():
		#set_direction()
		if Input.is_action_pressed("run"):
			finished.emit('Sprint')
		elif direction != Vector3.ZERO:
			#sprint_ended.emit()
			emit_signal('sprint_ended')
			finished.emit('Run')
		else:
			emit_signal('sprint_ended')
			finished.emit('Idle')
