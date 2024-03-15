extends Node2D

@export var MISSILE: PackedScene = null

var target: Node2D = null
var enemies_in_range: Array[Area2D]

@onready var gunSprite = $GunSprite
@onready var rayCast = $RayCast2D
@onready var reloadTimer = $RayCast2D/ReloadTimer

func _ready():
	await get_tree().process_frame
	reloadTimer.stop()


func _physics_process(delta):
	
	#var space_state = get_world_2d().direct_space_state
	## use global coordinates, not local to node
	#var origin = global_position
	#var query = PhysicsRayQueryParameters2D.create(origin, Vector2(250, 0))
	#query.collide_with_areas = true
	#var result = space_state.intersect_ray(query)
	#if result.size() > 0:
		#print('Raycast detected collision. Result: ', result)
	
	if target != null:
		var angle_to_target: float = global_position.direction_to(target.global_position).angle()
		rayCast.global_rotation = angle_to_target
		gunSprite.global_rotation = angle_to_target + deg_to_rad(90)
		#if rayCast.is_colliding(): 
			#print("turret physicsprocess, raycastCollider: ", rayCast.get_collider(), "raycast collider owner", rayCast.get_collider().owner)
		if rayCast.is_colliding() and rayCast.get_collider().is_in_group("mob"):
			if reloadTimer.is_stopped():
				shoot()
	#else: target = find_target()

func shoot():
	print("PEW")
	rayCast.enabled = false
	
	if MISSILE:
		var missile: Node2D = MISSILE.instantiate()
		get_tree().current_scene.add_child(missile)
		missile.global_position = global_position
		missile.global_rotation = rayCast.global_rotation
		
	reloadTimer.start()

func find_target():
	var new_target: Node2D = null
	print('acquiring new target...')
	if !enemies_in_range.is_empty():
		new_target = enemies_in_range[0]
	print('new target acquired: ', new_target)
	return new_target


func _on_reload_timer_timeout():
	rayCast.enabled = true


func _on_patrol_zone_area_entered(area):
	print("PATROL ZONE ENTERED: ", area)
	print('target before: ', target)
	if target == null:
		target = area
	enemies_in_range.append(area)
	print(' - Enemies in range - Size: ',enemies_in_range.size(), " Contents: ", enemies_in_range)
	print('target after: ', target)


func _on_patrol_zone_area_exited(area):
	print("PATROL ZONE EXITED: ", area)
	enemies_in_range.erase(area)
	print('new enemies_in_range array. Size: ',enemies_in_range.size(), " Contents: ", enemies_in_range)
	print('target before: ', target)
	if target == area:
		target = find_target()
	print('target after: ', target)
