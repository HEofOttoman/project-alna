extends Area3D

@export var item_types : Array[ItemData]= []

var nearby_bodies : Array[InteractibleItem]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		pick_up_nearest_item()

func pick_up_nearest_item():
	var nearest_item : InteractibleItem = null
	var nearest_item_distance : float = INF
	for item in nearby_bodies:
		if (item.global_position.distance_to(global_position) < nearest_item_distance):
			nearest_item_distance = item.global_position.distance_to(global_position)
			nearest_item = item
		
		if nearest_item != null:
			nearest_item.queue_free()
			nearby_bodies.erase(item)
			var item_prefab : = nearest_item.scene_file_path
			for i in item_types.size():
				if (item_types[i].item_model_prefab != null and item_types[i].item_model_prefab.resource_path):
					print("Item ID: " + str(i) + "Item Name: " + item_types[i].item_name)
					return
			
			printerr('Item not found')

func _on_object_entered_area(body: Node3D):
	if (body is InteractibleItem):
		body.gain_focus()
		nearby_bodies.append(body)

func _on_object_exited_area(body: Node3D):
	if (body is InteractibleItem and nearby_bodies.has(body)):
		body.lose_focus()
		nearby_bodies.remove_at(nearby_bodies.find(body))
