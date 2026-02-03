extends Enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_to_player(delta)

func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = rng.randf_range(2.5, 3.5)
	if position.distance_to(player.position) < 5.0:
		melee_attack_animation()
	else:
		pass
		#if rng.randi() % 2:
			#ranged_attack_animation()
		#else: 
			#spin_attack_animation()
		#ranged_attack_animation()
	# 4 attack animations
	# 2 ranged
	# 2 melee

func melee_attack_animation() -> void:
	#attack_animation.animation = simple_attacks['slice' if rng.randi() % 2 else 'spin']
	$AnimationTree.set('parameters/AttackOneShot/request', AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
