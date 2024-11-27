extends Node2D


# var
var entities: Array[CharacterBody2D]


# ====================================================================================================
#
# Functions
func deal_damage(entity: CharacterBody2D, damage: int):
	if entity.attackable and entity.health > 0:
		entity.health -= damage

		print('Entity ', entities[entities.find(entity)], ' is attackable! Took ', damage, ' damage!')
		print('Health ', entity.health)

		if entity.health <= 0:
			kill(entity)

			print(entity, ' died!')
			print('All entities: ', entities)
		else:
			entity.animation.play('take_damage')
	else:
		print('Entity ', entities[entities.find(entity)], ' is not attackable!')

	print('\n')

func kill(entity: CharacterBody2D):
	entity.die()

	if entities.has(entity):
		entities.remove_at(entities.find(entity))

func load_entity(entity: CharacterBody2D):
	entities.append(entity)

	print(entities[entities.find(entity)])
	print('Health: ', entities[entities.find(entity)].health)
	print('All entities: ', entities)
	print('\n')

func reset():
	entities.clear()
