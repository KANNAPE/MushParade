extends Control

@onready var return_button = %ReturnButton

func _on_return_button_pressed():
	SceneManager.push_scene( SceneManager.SceneID.SC_MainMenu )


func _on_deck_button_pressed():
	SceneManager.push_scene( SceneManager.SceneID.SC_UnitSelection )
