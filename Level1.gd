extends Node2D

@export var ENEMY: PackedScene = null
@export var ENEMY_PATH: PackedScene = null
signal enemy_spawned(path: Path2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ReloadTimerLabel.text = "Reload Timer: \n" + str($Turret/RayCast2D/ReloadTimer.time_left)
	$EnemyTimer/EnemyTimerLabel.text = "Enemy Timer: \n" + str($EnemyTimer.time_left)

func _on_enemy_timer_timeout():
	var new_enemy_path = ENEMY_PATH.instantiate()
	add_child(new_enemy_path)
	#print('enemy added')
