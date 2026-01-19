extends Node3D

## Tutorial: https://www.youtube.com/watch?v=AoGOIiBo4Eg

@onready var movement_state_machine = $AnimationTree.get("parameters/Movement-StateMachine/playback")

func set_movement_state(state_name : String):
	movement_state_machine.travel(state_name)

func animate_attack() -> void: ## Plays the attack animation
	$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func animate_interact() -> void:
	pass

## Not sure if this the right use of blend
# Timestamp: 2:29:48
func aim(aim_up: bool) -> void: ## Should be used to blend between aiming and moving
	var tween = create_tween()
	tween.tween_method(_aiming_change, 1.0 - float(aim_up), float(aim_up), 0.25)

func _aiming_change(value: float) -> void:
	$AnimationTree.set("parameters/AimBlend/blend_amount", value)
