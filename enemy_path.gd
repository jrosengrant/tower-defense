extends Node2D

@export var speed = 50
var path = null
var path_follow = null
var enemy = null

signal base_reached(damage: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	path = $Path2D
	path_follow = $Path2D/PathFollow2D
	enemy = $Path2D/PathFollow2D/Enemy
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path_follow.progress += speed * delta
	if path_follow.progress_ratio == 1:
		base_reached.emit(1)
		destroy()

func destroy():
	if is_instance_valid(path):
		queue_free()


func _on_enemy_area_entered(area):
	if area.is_in_group("missiles"):
		print('ENEMY DESTROYED: ', $Path2D/PathFollow2D/Enemy)
		destroy()
