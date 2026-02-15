extends PanelContainer
## The Inventory Interface scene

@export var SLOT : PackedScene = preload("uid://cfrdqwekvhiup")
#const SLOT : PackedScene = preload("uid://cfrdqwekvhiup")

@onready var item_grid: GridContainer = %ItemGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var inventory_data = preload("uid://cxr4ar873f0hw")
	populate_item_grid(inventory_data.slot_datas)

## Updates the inventory interface
func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data.slot_datas)

## Programmatically adds slot children to the inventory
func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in slot_datas:
		var slot = SLOT.instantiate()
		item_grid.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
