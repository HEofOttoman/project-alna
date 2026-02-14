extends Area3D

## Aka 'detector'
## Attached to an Area3D which is parented to the player.

## 
@export var indicator_prompt : Label
#@export var item_types : Array[ItemData]= []

var nearby_bodies : Array[Interactible]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var target : Interactible = target_nearest_item()
		if target:
			target._interact(self)

func interact_with_object() :
	pass

## Targets the nearest item in the area
func target_nearest_item() -> Interactible:
	var nearest_item : Interactible = null
	
	if nearby_bodies.is_empty():
		return null
	
	var nearest_item_distance : float = INF
	for item in nearby_bodies:
		if (item.global_position.distance_to(global_position) < nearest_item_distance):
			nearest_item_distance = item.global_position.distance_to(global_position)
			nearest_item = item
			#indicator_prompt.text = nearest_item.prompt_message
			print("nearest item: ", nearest_item)
			return nearest_item
		
		## not sure what this code from bonkahe does
		#if nearest_item != null:
			#nearest_item.queue_free()
			#nearby_bodies.erase(item)
			#var item_prefab : = nearest_item.scene_file_path
			#for i in item_types.size():
				#if (item_types[i].item_prefab != null and item_types[i].item_model_prefab.resource_path):
					#print("Item ID: " + str(i) + "Item Name: " + item_types[i].item_name)
					#return
			
			#printerr('Item not found')
	printerr('Item not found')
	return null


func _on_object_entered_area(body: Node3D):
	#if (body is Interactible):
		#body.gain_focus()
		#nearby_bodies.append(body)
	# or .. https://www.youtube.com/watch?v=DsM3ZWUVxfc
	#if body.get_parent() is Interactible: nearby_bodies.append(body.get_parent
	if body.get_parent() is Interactible: 
		nearby_bodies.append(body.get_parent()) # I didn't call the function
		indicator_prompt.text = body.get_parent().prompt_message
	


func _on_object_exited_area(body: Node3D):
	#if (body is Interactible and nearby_bodies.has(body)):
		#body.lose_focus()
		#nearby_bodies.remove_at(nearby_bodies.find(body))
	# or .. https://www.youtube.com/watch?v=DsM3ZWUVxfc
	#if body.get_parent() is Interactible: nearby_bodies.erase(body.get_parent) 
	if body.get_parent() is Interactible: 
		nearby_bodies.erase(body.get_parent()) # ohh that's why
		indicator_prompt.text = ""
		
