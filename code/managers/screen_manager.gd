extends Node

enum SceneID {
	SC_MainMenu,
	SC_DeckSelection,
	SC_UnitSelection,
} 

const MAIN_MENU_SCENE = preload( "res://data/levels/main_menu.tscn" )
const DECK_SELECTION_SCENE = preload( "res://data/levels/deck_selection.tscn" ) 
const UNIT_SELECTION_SCENE = preload( "res://data/levels/unit_selection.tscn" )

func _change_scene( scene: PackedScene ):
	var root_scene = get_tree().root
	var current_scene = root_scene.get_child( 1 )
	root_scene.remove_child( current_scene )
	root_scene.add_child( scene.instantiate() )


func push_scene( scene_id: SceneID ):
	match( scene_id ):
		SceneID.SC_MainMenu:
			_change_scene( MAIN_MENU_SCENE )
		SceneID.SC_DeckSelection:
			_change_scene( DECK_SELECTION_SCENE )
		SceneID.SC_UnitSelection:
			_change_scene( UNIT_SELECTION_SCENE )
