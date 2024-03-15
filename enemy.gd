extends Node2D

func destroy():
	queue_free()

#func _on_area_entered(area):
	#if area.is_in_group("missiles"):
		#print('enemy destroyed')
		#destroy()
