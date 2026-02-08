extends MotionState
### AKA aim_idle
### This might be redundant to add as a seperate state, a better way could exist

signal aim_entered
signal aim_released

func _enter() -> void:
	print(name)
	emit_signal("aim_entered")

func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		emit_signal("aim_exited")
		finished.emit('Jump')
	
	if _event.is_action_released("aim"):
		emit_signal("aim_released")
		finished.emit('Idle')

func _update(_delta: float):
	set_direction()
	#calculate_velocity(AIMING_SPEED, direction, _delta)
	calculate_velocity(aiming_speed, direction, PLAYER_MOVEMENT_SETTINGS.acceleration, _delta)
	replenish_sprint(_delta)
	
	if direction != Vector3.ZERO:
		#emit_signal("aim_released")
		#finished.emit('Run')
		finished.emit('AimRun')
	
	if not is_on_floor():
		emit_signal("aim_released")
		finished.emit('Fall')
		# ooo maybe I could add bullet time here
	
