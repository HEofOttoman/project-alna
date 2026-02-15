#extends Node
extends Resource
class_name InventoryData
## The data of an entity's  (player's) inventory, made up of an array of slot_data resources.

#@export var items : Array[ItemData]
@export var slot_datas : Array[SlotData]
