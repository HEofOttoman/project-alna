extends Node3D
class_name Interactible

@export var prompt_message : String = "[E] Interact"
@export var item_highlight_mesh : MeshInstance3D

#@onready var item_highlight = item_highlight_mesh.get_active_material(0).next_pass

# its supposed to apply the glint effect to the item
#
#func gain_focus():
	#item_highlight_mesh.visible = true
#
#func lose_focus():
	#item_highlight_mesh.visible = false
	#

## The logic that is to happen when the interaction is called. Inherit a new class for each object (or find a way to use resources instead( 
func _interact(_actor: Node):
	pass #return
