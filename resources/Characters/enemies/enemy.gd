extends CharacterBody3D
class_name Enemy
## Enemy class based on: https://www.youtube.com/watch?v=AoGOIiBo4Eg
## Broken if used alone

@export_group("Movement Settings")
@export var base_speed : float = 2.0
@export var run_speed : float = 6.0
@export var speed_while_aiming : float = 2.0
@export var speed_modifier : float = 1.0

@export_group('Enemy Settings')
@export var notice_radius : float = 20.0
@export var attack_radius : float = 3.0

@onready var attack_animation = $AnimationTree.get_tree_root().get_node('AttackAnimation')
var rng := RandomNumberGenerator.new()
@onready var move_state_machine : Resource = $AnimationTree.get('parameters/MoveStateMachine/playback')
@onready var skin: Node3D = $Skin
@onready var player:= get_tree().get_first_node_in_group('Player')

func move_to_player(delta): ## moves the enemy towards the player
	
	if position.distance_to(player.position) < notice_radius:
		var target_direction : Vector3 = (player.position - position).normalized()
		var target_direction_vec2 : Vector2 = Vector2(target_direction.x, target_direction.z)
		var target_angle = -target_direction_vec2.angle() + PI/2
		rotation.y = rotate_toward(rotation.y, target_angle, delta * 6.0)
		if position.distance_to(player.position) > attack_radius:
			velocity = Vector3(target_direction_vec2.x, 0, target_direction_vec2.y) * base_speed * speed_modifier
			move_state_machine.travel('walk')
		else:
			velocity = Vector3.ZERO
			move_state_machine.travel('idle')
		move_and_slide()
	#move_toward(delta, , target_direction)

func stop_movement(start_duration: float, end_duration: float): ## Aka stop movement
	var tween = create_tween()
	tween.tween_property(self, "speed_modifier", 0.0, start_duration)
	tween.tween_property(self, "speed_modifier", 1.0, end_duration)

func hit_receive():
	if not $Timers/InvulTimer.time_left:
		print('enemy was hit')
		$Timers/InvulTimer.start()
