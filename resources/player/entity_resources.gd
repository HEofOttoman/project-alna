extends Node
class_name EntityResources

## From this very convoluted tutorial - https://www.youtube.com/watch?v=b3uFSh3GASs
## Might make into an actual resource later..?

@export var god_mode: bool = false

@export var health: float = 100.0
@export var max_health: float = 100.0

@export var stamina : float = 100.0
@export var max_stamina : float = 100.0

@export var stamina_regeneration_rate : float = 10.0 # per second

@export var statuses: Array = [] ## As in status effects

#@onready var model = $".." #as PlayerModel

signal health_changed(health)

func _ready() -> void:
	health_changed.emit(health)

func update(delta: float):
	gain_stamina(stamina_regeneration_rate * delta)
	gain_health(0.5 * delta)

func lose_health(amount: float):
	if not god_mode:
		health -= amount
		health_changed.emit(health)
		if health < 1:
			pass#die()

func gain_health(amount: float):
	if health + amount <= max_health:
		health += amount
		health_changed.emit(health)
	else:
		health = max_health
		health_changed.emit(health)

func lose_stamina(amount: float):
	if not god_mode:
		stamina -= amount
		if stamina < 1:
			statuses.append("fatigue")

func gain_stamina(amount: float):
	if stamina + amount < max_stamina:
		stamina += amount
	else:
		stamina = max_stamina
	if stamina > 10.0: # 10.0 is fatigue threshold
		statuses.erase("fatigue")
