extends Label

func on_health_changed(health: float):
	text = str('HEALTH: ', health)
