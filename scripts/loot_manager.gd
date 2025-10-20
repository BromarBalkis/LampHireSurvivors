extends Node
# LootManager.gd - Add this as an Autoload in Project Settings

var upgrade_pool = [
	{"name": "Attack Speed", "stat": "atk_spd", "base_value": 0.2, "enhanced_value": 0.5, "rarity": "common", "description": "Increases attack speed"},
	{"name": "Damage", "stat": "dmg_mult", "base_value": 0.2, "enhanced_value": 0.5, "rarity": "common", "description": "Increases damage"},
	{"name": "Move Speed", "stat": "speed_mult", "base_value": 0.2, "enhanced_value": 0.5, "rarity": "common", "description": "Increases movement speed"},
	{"name": "Max HP", "stat": "max_hp", "base_value": 20, "enhanced_value": 50, "rarity": "uncommon", "description": "Increases maximum health"},
	{"name": "HP Regen", "stat": "hp_regen", "base_value": 1, "enhanced_value": 3, "rarity": "uncommon", "description": "Regenerate health over time"},
	{"name": "Projectile Size", "stat": "projectile_size", "base_value": 0.15, "enhanced_value": 0.4, "rarity": "rare", "description": "Increases projectile size"},
	{"name": "Exp Gain", "stat": "exp_mult", "base_value": 0.1, "enhanced_value": 0.3, "rarity": "rare", "description": "Gain more experience"},
	{"name": "Luck", "stat": "luck", "base_value": 0.1, "enhanced_value": 0.25, "rarity": "epic", "description": "Better loot drops"},
]

var item_pool = [
	{"name": "Garlic", "rarity": "common", "effect": "passive_aura", "description": "Damages nearby enemies"},
	{"name": "Holy Water", "rarity": "common", "effect": "ground_damage", "description": "Creates damaging pools"},
	{"name": "Magic Wand", "rarity": "uncommon", "effect": "projectile_weapon", "description": "Fires magic projectiles"},
	{"name": "Knife", "rarity": "uncommon", "effect": "projectile_weapon", "description": "Throws knives"},
	{"name": "Bible", "rarity": "rare", "effect": "orbital_weapon", "description": "Orbits around player"},
	{"name": "King Bible", "rarity": "epic", "effect": "orbital_weapon", "description": "Upgraded Bible with more damage"},
	{"name": "Lightning Ring", "rarity": "rare", "effect": "chain_lightning", "description": "Strikes multiple enemies"},
	{"name": "Laurel", "rarity": "epic", "effect": "shield", "description": "Grants temporary invulnerability"},
]

var rarity_weights = {
	"common": 60,
	"uncommon": 25,
	"rare": 12,
	"epic": 3
}

func get_random_upgrades(count: int) -> Array:
	var available_upgrades = upgrade_pool.duplicate()
	var selected = []
	
	for i in count:
		if available_upgrades.is_empty():
			break
			
		var upgrade = get_weighted_random(available_upgrades)
		
		# Roll for enhanced value (10% chance for better upgrade)
		if randf() < 0.10:
			upgrade = upgrade.duplicate()
			upgrade["is_enhanced"] = true
		else:
			upgrade = upgrade.duplicate()
			upgrade["is_enhanced"] = false
			
		selected.append(upgrade)
		available_upgrades.erase(upgrade)
	
	return selected

func get_random_items(count: int) -> Array:
	var available_items = item_pool.duplicate()
	var selected = []
	
	for i in count:
		#TODO: eventually replace this with gold drop ? 
		if available_items.is_empty():
			break
			
		var item = get_weighted_random(available_items)
		selected.append(item)
		available_items.erase(item)
	
	return selected

# Weighted random selection based on rarity
func get_weighted_random(pool: Array):
	var total_weight = 0
	
	# Calculate total weight
	for entry in pool:
		total_weight += rarity_weights[entry.rarity]
	
	# Random selection
	var random_value = randf() * total_weight
	var current_weight = 0
	
	for entry in pool:
		current_weight += rarity_weights[entry.rarity]
		if random_value <= current_weight:
			return entry
	
	return pool[0] # Fallback

# Get items for shop (shows multiple, player picks one)
func get_shop_items(count: int) -> Array:
	return get_random_items(count)

# Apply upgrade to player
func apply_upgrade(player: CharacterBody2D, upgrade: Dictionary) -> void:
	var value = upgrade.enhanced_value if upgrade.get("is_enhanced", false) else upgrade.base_value
	
	match upgrade.stat:
		"atk_spd":
			player.player_atk_spd += value
		"dmg_mult":
			player.player_dmg_mult += value
		"speed_mult":
			player.player_speed_mult += value
		"max_hp":
			player.player_max_hp += value
		"hp_regen":
			player.player_hp_regen += value
		"projectile_size":
			player.player_projectile_size += value
		"exp_mult":
			player.player_exp_mult += value
		"luck":
			player.player_luck += value
