extends Control

enum MenuButtonType {
	SETTINGS,
	QUIT
}

@onready var menu_button := $MenuButton

func _ready():
	var popup_menu = menu_button.get_popup()
	popup_menu.id_pressed.connect(_on_menu_button_pressed)


func _on_play_button_pressed():
	print("Play!")


func _on_decks_button_pressed():
	print("Decks selection")
	SceneManager.push_scene( SceneManager.SceneID.SC_DeckSelection )


func _on_menu_button_pressed(id: int):
	if( id == MenuButtonType.SETTINGS ):
		print("Settings have been saved!")
	elif( id == MenuButtonType.QUIT ):
		get_tree().quit()
