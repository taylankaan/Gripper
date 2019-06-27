	extends Control


func _ready():
	pass 






func _on_OptionsB_pressed():
	pass # Replace with function body.


func _on_StartB_pressed():
	G.starButtonPressed=true;
	get_tree().change_scene("res://scenes/gameplay.tscn")