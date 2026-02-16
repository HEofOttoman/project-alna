extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/Icon
@onready var quantity_label: Label = $QuantityLabel


func set_slot_data(slot_data: SlotData):
	var item_data = slot_data.item_data
	icon.texture = item_data.icon
	icon.show()
	tooltip_text = "%s\n%s" % [item_data.item_name, item_data.description]
	
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()
	else:
		quantity_label.text = ""
		#quantity_label.hide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
