extends Node


# Simula um dado de 100 lados [D100]
func get_chance():
	return int(rand_range(1,100))
	pass # func get_chance


# Retorna uma Arma aleatoria
func random_weapon():
	var weapon_chance = get_chance() 
	if weapon_chance < 50:
		return "Bow"
	elif weapon_chance >= 50:
		return "Axe"
	pass # func random_weapon

# Retorna uma Ação (Monstro/Poção) aleatoria
func random_action():
	var action_chance = get_chance()
	if action_chance < 60:
		return "Ogre"
	elif action_chance >= 50:
		var potion_chance = get_chance()
		if potion_chance < 50:
			return "Moon"
		elif potion_chance >= 50:
			return "Sun"
	pass # func random_action

# Retorna um Local aleatorio
func random_local():
	var local_chance = get_chance()
	if local_chance < 50:
		return "Dungeon"
	elif local_chance >= 50:
		return "Forest"
	pass # func random_local




