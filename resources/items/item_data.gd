extends Resource
class_name ItemData
## Item resources, for displaying in inventory and instantiating

## Display name
@export var item_name : StringName
## Internal name, if need be for differentiation
@export var internal_name : StringName
## Description for the item
@export_multiline var description : String = ""

@export var stackable : bool = false

@export var icon : Texture

@export var item_model_prefab : PackedScene

@export_enum("Default", "Materials", "Weapons", "Key Items") var item_type : String
