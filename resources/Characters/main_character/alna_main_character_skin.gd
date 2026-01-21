extends Node3D

## Tutorial: https://www.youtube.com/watch?v=AoGOIiBo4Eg

@onready var movement_state_machine = $AnimationTree.get("parameters/Movement-StateMachine/playback")
@onready var attack_state_machine = $AnimationTree.get("parameters/Attack-StateMachine/playback")

var equipped_weapon ## Currently equipped weapon
# ^For possible future use in switch_weapon()
@onready var equipped_gun: MeshInstance3D = $CharacterArmature/Skeleton3D/Pistol


var is_attacking : bool = false

func set_movement_state(state_name : String):
	movement_state_machine.travel(state_name)

func animate_attack() -> void: ## Plays the attack animation
	if not is_attacking:
		attack_state_machine.travel('Sword_Slash' if $AttackTimer.time_left else 'Punch_Left')
		$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	

# Timestampt: 2:39:00
func attack_toggle(value: bool) -> void:
	is_attacking = value

func animate_interact() -> void:
	pass

## Changes shown weapon model
# Timestamp 2:52:00
func switch_weapon(weapon_active : bool) -> void:
	if weapon_active == true:
		$CharacterArmature/Skeleton3D/Sword.show() ## Later should instead show the equipped weapon
		equipped_gun.hide()
	else:
		$CharacterArmature/Skeleton3D/Sword.hide()
		equipped_gun.show()

## Not sure if this the right use of blend
# Timestamp: 2:29:48
func aim(aim_up: bool) -> void: ## Should be used to blend between aiming and moving
	var tween = create_tween()
	tween.tween_method(_aiming_change, 1.0 - float(aim_up), float(aim_up), 0.25)

func _aiming_change(value: float) -> void:
	$AnimationTree.set("parameters/AimBlend/blend_amount", value)

func hit_received(): ## Character gets damaged
	pass
