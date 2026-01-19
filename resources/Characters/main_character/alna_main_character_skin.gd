extends Node3D


@onready var movement_state_machine = $AnimationTree.get("parameters/Movement-StateMachine/playback")

func set_movement_state(state_name : String):
	movement_state_machine.travel(state_name)

func animate_attack() -> void: ## Plays the attack animation
	$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
