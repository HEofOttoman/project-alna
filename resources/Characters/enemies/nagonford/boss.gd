extends Enemy
## Based on https://www.youtube.com/watch?v=AoGOIiBo4Eg

const simple_attacks = {
	'slice' : "2H_Melee_Attack_Slice",
	'spin' : "2H_Melee_Attack_Spin",
	'range' : "1H_Melee_Attack_Stab"
}

@export var spin_speed = 6.0
@export var spinning := false

func _ready() -> void:
	print(player)

func _process(delta: float) -> void:
	move_to_player(delta)

func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = rng.randf_range(4.0, 5.5)
	if position.distance_to(player.position) < 5.0:
		melee_attack_animation()
	else:
		if rng.randi() % 2:
			ranged_attack_animation()
		else: 
			spin_attack_animation()
		#ranged_attack_animation()
	# 4 attack animations
	# 2 ranged
	# 2 melee
	

func ranged_attack_animation() -> void:
	stop_movement(1.5, 1.5)
	attack_animation.animation = simple_attacks['range']
	$AnimationTree.set('parameters/AttackOneShot/request', AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	

func spin_attack_animation() -> void:
	var tween = create_tween()
	tween.tween_property(self, "speed_modifier", spin_speed, 0.5)
	tween.tween_method(spin_transition, 0.0, 1.0, 0.3)
	$Timers/AttackTimer.stop()
	spinning = true

func spin_transition(value: float):
	$AnimationTree.set('parameters/SpinBlend/blend_amount', value)
	

func melee_attack_animation() -> void:
	attack_animation.animation = simple_attacks['slice' if rng.randi() % 2 else 'spin']
	$AnimationTree.set('parameters/AttackOneShot/request', AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

## Stops
func _on_area_3d_body_entered(_body: Node3D) -> void:
	#print(body) # Replace with function body.
	if spinning:
		await get_tree().create_timer(randf_range(1.0, 2.0)).timeout
		var tween = create_tween()
		tween.tween_property(self, "speed_modifier", base_speed, 0.5)
		tween.tween_method(spin_transition, 1.0, 0.0, 0.3)
		spinning = false
		$Timers/AttackTimer.start( )
