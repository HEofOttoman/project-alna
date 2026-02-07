extends MotionState

signal sprint_started
signal sprint_ended

func _enter() -> void:
	sprint_started.emit()
	print('CurrentState: ', name)

#func _exit() -> void:
	#sprint_ended.emit()

func _state_input(_event: InputEvent) -> void:
	if _event.is_action_pressed("jump"):
		finished.emit('SprintJump')
	
	if _event.is_action_released("run"): ## Run is the input name for sprinting
		sprint_ended.emit()
		finished.emit('Run')

func _update(_delta: float):
	set_direction()
	calculate_velocity(SPRINT_SPEED, direction, _delta)
	
	sprint_remaining -= _delta
	get_tree().create_timer(SPRINT_DURATION)
	
	if sprint_remaining <= 0.0:
		sprint_ended.emit()
		finished.emit('Run')
	
	if direction == Vector3.ZERO:
		sprint_ended.emit()
		finished.emit('Idle')
	
	if not is_on_floor():
		finished.emit('SprintFall')
