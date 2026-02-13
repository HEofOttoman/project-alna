extends Resource 
class_name Weapons

## Based on https://www.youtube.com/watch?v=SB0QrnI_-IQ

@export var name : StringName
@export_category('Weapon Orientation')
@export var position : Vector3
@export var rotation : Vector3
@export_category('Visual Settings')
@export var mesh : Mesh
@export var shadow : bool
