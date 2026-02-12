extends Interactible

@export var is_open : bool = false

func _interact(_actor: Node):
	if is_open == false:
		$AnimationPlayer.play("Chest_Open")
		print("chest open")
		is_open = true
	else:
		$AnimationPlayer.play("Chest_Close")
		print("chest closing")
		is_open = false
