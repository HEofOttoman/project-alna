extends Interactible

## The item 3D object itself.

@export var item_data : ItemData

#@onready var model = item_data.item_model_prefab.instantiate()

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _interact(_actor: Node):
	pick_up(_actor)

## Idk, will add the item to the actor?
func pick_up(actor):
	return actor


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#pass
