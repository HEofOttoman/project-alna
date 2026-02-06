class_name WeaponController
extends Node

## Script that manages the current weapon and its data.

@export var current_weapon : Weapon
@export var weapon_model_parent: Node3D

@export var current_weapon_model: Node3D

func _ready() -> void:
	if current_weapon_model:
		spawn_weapon_model()

func spawn_weapon_model():
	if current_weapon_model:
		current_weapon_model.queue_free()
	
	if current_weapon.weapon_model:
		current_weapon_model = current_weapon.weapon_model.instantiate()
		weapon_model_parent.add_child(current_weapon_model)
		current_weapon_model.position = current_weapon.weapon_position
