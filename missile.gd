extends Area2D

const angle = Vector2.RIGHT
@export var SPEED: int = 300

func _ready():
	$Sprite2D.rotation = global_rotation + deg_to_rad(90)
	#print("global rotation: ", global_rotation, "Sprite rotation: ", $Sprite2D.rotation)

func _physics_process(delta):
	#print('physics process global rotation: ', global_rotation)
	var movement = angle.rotated(global_rotation + deg_to_rad(5)) * SPEED * delta
	#print('missile rotation, global: ', global_rotation, ' local: ', rotation)
	global_position += movement

func destroy():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("mob"):
		destroy()
