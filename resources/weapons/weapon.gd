extends Resource 
class_name Weapon

## Based on https://www.youtube.com/watch?v=3-SDNBCZA7M

@export var weapon_name : StringName
@export_category('Visual Settings')
@export var weapon_model : PackedScene
@export var mesh : Mesh
@export var shadow : bool

@export_category('Weapon Orientation')
@export var weapon_position : Vector3
@export var rotation : Vector3

@export_category('Stats')
@export var damage: float
@export var ammo: int
