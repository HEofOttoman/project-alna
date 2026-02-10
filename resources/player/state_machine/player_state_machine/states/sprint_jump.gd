extends MotionState

signal sprint_ended

func _enter() -> void:
	print('current state: ', name) ## Somehow the enter func in MotionState doesn't work..
	## Oh yeah that cuz this overrides enter
	jump()

#func _state_input(_event: InputEvent) -> void:
	#if _event.is_action_released("run"):
		#sprint_ended.emit()

func _update(_delta: float):
	set_direction()
	calculate_velocity(sprint_speed, direction, PLAYER_MOVEMENT_SETTINGS.in_air_acceleration, _delta)
	calculate_gravity(_delta)
	
	if is_on_floor(): # Should fix bug if jump immediately onto another surface
		if Input.is_action_pressed("run"):
			finished.emit('Sprint')
		#elif direction != Vector3.ZERO:
			##sprint_ended.emit()
			#emit_signal('sprint_ended')
			#finished.emit('Run')
	
	if velocity.y <= 0:
		finished.emit('Fall')

func jump() -> void:
	velocity.y = jump_velocity

### Taken from V1 character controller
## Handles Jumping 
#func jump_logic(delta) -> void:
	#if is_on_floor():
		### ui_accept is current jump action
		#if Input.is_action_just_pressed("jump"): #and is_on_floor():
			#velocity.y = -jump_velocity
			#squash_and_stretch(1.1, 0.5)
	#else: ## Plays an animation after player gets off the floor
		##character_skin.set_movement_state('Roll') ## I should make a dedicated jump animation, is roll for now
		#character_skin.set_movement_state('Jump') ## I should make a dedicated jump animation, is roll for now
	#var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	#velocity.y -= gravity * delta
