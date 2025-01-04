extends Node2D


# var
var entities: Array[CharacterBody2D]


# ====================================================================================================
#
# Functions
func deal_damage(entity: CharacterBody2D, damage: int):
	if entity.attackable and entity.health > 0:
		entity.health -= damage

		SignalBus._message.emit(str(entity.name, ' took ', damage, ' damage '))
		#print(entity, ' health: ', entity.health)

		if entity.health <= 0:
			kill(entity)

			SignalBus._message.emit(str(entity.name, ' murdered!'))
			#print('All entities: ', entities)
		else:
			entity.animation.play('take_damage')
	else:
		pass
		#print(entity, ' is not attackable!')

	#print('\n')

func kill(entity: CharacterBody2D):
	entity.die()

	if entities.has(entity):
		entities.remove_at(entities.find(entity))

func load_entity(entity: CharacterBody2D):
	entities.append(entity)

	print('ENTITY MANAGER')
	print('load_entity()')
	print('==========')
	print(entities[entities.find(entity)])
	print('Health: ', entities[entities.find(entity)].health)
	print('All entities: ', entities)
	print('\n')

func reset():
	entities.clear()
