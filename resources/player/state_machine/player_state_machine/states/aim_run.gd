extends MotionState
## This might be redundant do add as another state, a better way could be added

signal aim_entered
signal aim_released

func _enter() -> void:
	print(name)
	emit_signal('aim_entered')

func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit('Jump')
	if _event.is_action_pressed("run") and sprint_remaining > 0.5:
		finished.emit('Sprint')
	
	if _event.is_action_released("aim"):
		emit_signal("aim_released")
		finished.emit('Idle')
	
	#if _event.is_action("aim") and direction == Vector3.ZERO:
		#finished.emit('AimIdle')

func _update(_delta: float):
	set_direction()
	#calculate_velocity(AIMING_SPEED, direction, _delta)
	calculate_velocity(aiming_speed, direction, PLAYER_MOVEMENT_SETTINGS.acceleration, _delta)
	replenish_sprint(_delta)
	
	if direction == Vector3.ZERO:
		emit_signal("aim_released")
		finished.emit('Idle')
	
	if not is_on_floor():
		emit_signal("aim_released")
		finished.emit('Fall')
