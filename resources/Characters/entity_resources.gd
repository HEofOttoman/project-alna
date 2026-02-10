extends Node
class_name EntityResources

## From this very convoluted tutorial - https://www.youtube.com/watch?v=b3uFSh3GASs
## Might make into an actual resource later

@export var god_mode: bool = false

@export var health: float = 100.0
@export var max_health: float = 100.0

@export var stamina : float = 100.0
@export var max_stamina : float = 100.0

@export var stamina_regeneration_rate : float = 10.0 # per second

@onready var model = $".." #as PlayerModel

func lose_health(amount: float):
	if not god_mode:
		health -= amount
		if health < 1:
			pass#die()

func gain_health(amount: float):
	if health + amount <= max_health:
		health += amount
	else:
		health = max_health

func lose_stamina(amount: float):
	if not god_mode:
		stamina -= amount
		if stamina < 1:
			pass#statuses.append("fatigue")

func gain_stamina(amount: float):
	if stamina + amount < max_stamina:
		stamina += amount
	else:
		stamina = max_stamina
	if stamina > 10.0: # 10.0 is fatigue threshold
		pass#statuses.erase("fatigue")
