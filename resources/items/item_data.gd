extends Resource
class_name ItemData

@export var item_name : StringName
@export_enum("Default", "Materials", "Weapons", "Key Items") var item_type : String
@export var item_model_prefab : PackedScene
