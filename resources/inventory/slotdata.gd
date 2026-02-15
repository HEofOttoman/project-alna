extends Resource
class_name SlotData
## Used for the inventory interfaces

const max_stack_size : int = 64

@export var item_data : ItemData
#@export_range(1, max_stack_size) var quantity : int = 1
@export_range(1, max_stack_size) var quantity : int = 1: set = set_quantity

func set_quantity(value: int):
	quantity = value
	if quantity > 1 and not item_data.stackable:
		push_error("ITEM %s IS NOT STACKABLE, returning quantity to 1" % item_data.item_name)
		quantity = 1
