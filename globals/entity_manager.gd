extends Node2D


# var
var entities: Array[CharacterBody2D]


# ====================================================================================================
#
# Functions
func deal_damage(entity: CharacterBody2D, damage: int):
	if entity.health - damage <= 0:
		entity.die()

		print(entity, ' died!')

	if entity.attackable and entity.health > 0:
		entity.health -= damage

		print('Bat ', entities.find(entity), ' is attackable! Took ', damage, ' damage!')
		print(entity.health)
	else:
		print('Bat ', entities[entities.find(entity)], ' is not attackable!')

func load_entity(entity: CharacterBody2D):
	entities.append(entity)

	print(entities[entities.find(entity)])
	print('Health: ', entities[entities.find(entity)].health)

func reset():
	entities.clear()
