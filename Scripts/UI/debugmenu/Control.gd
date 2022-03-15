extends NinePatchRect


onready var partyIcons = [$VBoxContainer/party/p1, $VBoxContainer/party/p2, $VBoxContainer/party/p3,$VBoxContainer/party/p4, $VBoxContainer/party/p5]



# Called when the node enters the scene tree for the first time.
func _ready():
	create_party()
	for i in range(global.party.size()):
		set_party_icon(i, global.party[i]['active'])

func _on_P1_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_player(0)
		set_party_icon(0, global.party[0]['active'])
		create_party()

func _on_p2_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_player(1)
		set_party_icon(1, global.party[1]['active'])
		create_party()


func _on_p3_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_player(2)
		set_party_icon(2, global.party[2]['active'])
		create_party()


func _on_p4_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_player(3)
		set_party_icon(3, global.party[3]['active'])
		create_party()


func _on_p5_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		set_player(4)
		set_party_icon(4, global.party[4]['active'])
		create_party()

func set_party_icon(number, status):
	if status:
		partyIcons[number].modulate = Color(1, 1, 1, 1)
	else:
		partyIcons[number].modulate = Color(1, 1, 1, 0.4)

func set_player(number):
	global.party[number]['active'] = !global.party[number]['active']
	
func create_party():
	global.create_party_followers()

func _process(delta):
	pass


