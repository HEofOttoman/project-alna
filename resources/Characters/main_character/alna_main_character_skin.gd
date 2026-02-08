extends Node3D

## Tutorial: https://www.youtube.com/watch?v=AoGOIiBo4Eg

@export var animation_tree : AnimationTree

@onready var movement_state_machine = $AnimationTree.get("parameters/Movement-StateMachine/playback")
@onready var attack_state_machine = $AnimationTree.get("parameters/Attack-StateMachine/playback")
@onready var extra_animation = $AnimationTree.get_tree_root().get_node('ExtraAnimation')
# ^This is a bit unnecessary imo, maybe I can try a statemachine later

var equipped_weapon ## Currently equipped weapon
# ^For possible future use in switch_weapon()
@onready var equipped_gun: MeshInstance3D = $CharacterArmature/Skeleton3D/Pistol

var is_attacking : bool = false
@export var squash_and_stretch_modifier : float = 1.0: ## Modifier for doing squash and stretch (don't change)
	set(value):
		squash_and_stretch_modifier = value
		var x_and_z_squash = 1.0 + (1.0 - squash_and_stretch_modifier)
		scale = Vector3(x_and_z_squash, squash_and_stretch_modifier, x_and_z_squash)
## It is possible to animate facial expressions by changing UV coordinates, the variable of which was here in the tutorial
## However I can't do that.
## It is a possible thing to do later though, is interesting.
## Timestamp: 3:22:00

func _on_state_machine_animation_state_changed(state: String) -> void:
	#animation_tree[""] = state
	set_movement_state(state)

func set_movement_state(state_name : String):
	movement_state_machine.travel(state_name)

func animate_attack() -> void: ## Plays the attack animation
	if not is_attacking:
		attack_state_machine.travel('Sword_Slash' if $AttackTimer.time_left else 'Punch_Left')
		punch(true) ## Idk trying to do this before I get an actual sword script
		$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	

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


# Timestamp: 2:58:00
func shoot_gun() -> void: ## Plays gun shot animation
	if not is_attacking:
		extra_animation.animation = 'Gun_Shoot'
		$AnimationTree.set("parameters/ExtraOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

## Not sure if this the right use of blend
# Timestamp: 2:29:48
func aim(aim_up: bool) -> void: ## Should be used to blend between aiming and moving
	var tween = create_tween()
	tween.tween_method(_aiming_change, 1.0 - float(aim_up), float(aim_up), 0.25)

func _aiming_change(value: float) -> void:
	$AnimationTree.set("parameters/AimBlend/blend_amount", value)

## Character gets damaged
func hit_receive(): # Timestamp: 2:59:00
	extra_animation.animation = 'HitReceive_2'
	$AnimationTree.set("parameters/ExtraOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_ABORT) 
	is_attacking = false # Stops current attack (& ^attack animation)
	

@onready var punch_raycast: RayCast3D = $"CharacterArmature/Skeleton3D/HandSlot-Right/PunchRaycast"
func punch(toggle: bool):
	var can_damage := toggle
	if can_damage == true:
		var collider = punch_raycast.get_collider()
		if collider and 'hit_receive' in collider:
			collider.hit_receive()
 
