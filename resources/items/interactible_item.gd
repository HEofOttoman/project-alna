extends Node3D
class_name InteractibleItem

@export var item_highlight_mesh : MeshInstance3D

func gain_focus():
	item_highlight_mesh.visible = true

func lose_focus():
	item_highlight_mesh.visible = false
	
