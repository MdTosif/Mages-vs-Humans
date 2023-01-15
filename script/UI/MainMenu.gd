extends Control


func _on_play_button_button_up():
	get_tree().change_scene("res://scenes/main.tscn")
	$AnimationPlayer.play("click")

func _on_credit_button_button_up():
	pass

func _on_play_button_button_down():
	$AnimationPlayer.play("click")

func _on_credit_button_button_down():
	$AnimationPlayer.play("click")
