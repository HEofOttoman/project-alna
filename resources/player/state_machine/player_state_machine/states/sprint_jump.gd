extends MotionState

func _enter() -> void:
	print('current state: ', name) ## Somehow the enter func in MotionState doesn't work..
	## Oh yeah that cuz this overrides enter
	jump()

func _update(_delta: float):
	set_direction()
	calculate_velocity(SPRINT_SPEED, direction, _delta)
	calculate_gravity(_delta)
	
	if velocity.y <= 0:
		finished.emit('Fall')

func jump() -> void:
	velocity.y = JUMP_VELOCITY

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
