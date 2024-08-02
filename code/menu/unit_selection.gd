extends Control

const MAX_UNITS_IN_DECK = 8
const LABEL_TEXT = "Units in deck: "
const DECK_FILE_PATH = "res://data/decks/deck_list.dck"

@onready var hbox_container = %HBoxContainer
@onready var units_label = %UnitInDeckLabel

var selected_units := Array( [], TYPE_INT, &"", null )
var unit_buttons : Array

func _ready():
	for button_idx in range(20):
		var node_name: String = str( "UnitButton", button_idx )
		var unit_button := hbox_container.get_node( node_name ) as UnitButton
		
		unit_button.toggled.connect( on_unit_selected.bind( unit_button ) )
		
		unit_buttons.push_back( unit_button )
		
	units_label.set_text( str( LABEL_TEXT, 0 ) )


func _on_return_button_pressed():
	SceneManager.push_scene( SceneManager.SceneID.SC_DeckSelection )


func _on_save_button_pressed():
	print( selected_units )
	
	var file = FileAccess.open( DECK_FILE_PATH, FileAccess.WRITE )
	save_current_deck( file )
	

#region deck_saving
func save_current_deck( deck_list_file: FileAccess ):
	var deck_list_content = {
		name = "my_deck",
		id = 0,
		units = selected_units
	}
	
	var json_string := JSON.stringify( deck_list_content, "\t" )
	
	deck_list_file.store_line( json_string )
#endregion


#region unit selection
func on_unit_selected( is_selected: bool, caller: UnitButton ):
	if is_selected:
		selected_units.push_back( caller.unit_id )
		if selected_units.size() == MAX_UNITS_IN_DECK:
			lock_buttons( true )
	else:
		#Fetching the clicked button ID in the array
		var unit_idx_in_array = 0
		for unit_id in selected_units:
			if unit_id == caller.unit_id:
				break
			unit_idx_in_array += 1
		
		#If previously locked, the buttons are now unlocked
		if selected_units.size() == MAX_UNITS_IN_DECK:
			lock_buttons( false )
		
		#Checking if we can safely remove the button and if so, remove it
		if unit_idx_in_array == selected_units.size():
			print( "Error!" )
		else:
			selected_units.remove_at( unit_idx_in_array )
	
	units_label.set_text( str( LABEL_TEXT, selected_units.size() ) )


func lock_buttons( lock: bool ):
	for unit_button: UnitButton in unit_buttons:
		if not unit_button.button_pressed:
			unit_button.set_disabled( lock )
#endregion
