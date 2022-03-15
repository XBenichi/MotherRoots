extends CanvasLayer

onready var arrow = $Commands/Arrow
onready var talk
onready var check

var pos = Vector2(0,0)
var active


# Called when the node enters the scene tree for the first time.
func _ready():
	set_text()


func _process(delta):
	$cash/Sign/Amount.text = var2str(globaldata.cash)
	global.persistPlayer.pause()
	active = uiManager.commandsMenuActive
	
	if active:
		if Input.is_action_just_pressed("ui_up"):
			pos = pos - Vector2(0,1)
		elif Input.is_action_just_pressed("ui_down"):
			pos = pos + Vector2(0,1)
		elif Input.is_action_just_pressed("ui_left"):
			pos = pos - Vector2(1,0)
		elif Input.is_action_just_pressed("ui_right"):
			pos = pos + Vector2(1,0)
		
		if pos == Vector2(2,pos.y):
			pos = Vector2(0,pos.y)
		elif pos == Vector2(-1,pos.y):
			pos = Vector2(1,pos.y)
		if pos == Vector2(pos.x,3):
			pos = Vector2(pos.x,0)
		elif pos == Vector2(pos.x,-1):
			pos = Vector2(pos.x, 2)
		
		match(pos):
			Vector2(0,0):
				arrow.rect_position.x = 4
				arrow.rect_position.y = 16
			Vector2(0,1):
				arrow.rect_position.x = 4
				arrow.rect_position.y = 32
			Vector2(0,2):
				arrow.rect_position.x = 4
				arrow.rect_position.y = 48
			Vector2(1,0):
				arrow.rect_position.x = 52
				arrow.rect_position.y = 16
			Vector2(1,1):
				arrow.rect_position.x = 52
				arrow.rect_position.y = 32
			Vector2(1,2):
				arrow.rect_position.x = 52
				arrow.rect_position.y = 48
		
		if Input.is_action_just_pressed("ui_accept"):
			match(pos):
				Vector2(0,0): #talk
					uiManager.open_dialogue_box()
				Vector2(1,0): #check
					uiManager.open_dialogue_box()
				Vector2(1,2): #stats
					create_stats_menu()
				Vector2(1,1): #PSI
					uiManager.start_battle()
					uiManager.battleMenuTemplate
					uiManager.remove_ui(self)
				
		
		if Input.is_action_just_pressed("ui_cancel"):
			uiManager.remove_ui(self)
			global.persistPlayer.unpause()
		
		
		
func create_stats_menu():
	var statsMenuTemplate = load("res://Nodes/Ui/stats menu.tscn")#"res://Nodes/Ui/stats menu.tscn"
	var statsMenu = statsMenuTemplate.instance()
	uiManager.stableCanvasLayer.add_child(statsMenu)
	uiManager.commandsMenuActive = false

func set_text():
	$Commands/title/Label.text = globaldata.text["stats"]["commands"]
	$Commands/Items/Talk.text = globaldata.text["actions"]["talk"]
	$Commands/Items/Check.text = globaldata.text["actions"]["check"]
	$Commands/Items/Goods.text = globaldata.text["actions"]["goods"]
	$Commands/Items/Map.text = globaldata.text["actions"]["map"]
	$Commands/Items/PSI.text = globaldata.text["actions"]["psi"]
	$Commands/Items/Stats.text = globaldata.text["actions"]["stats"]
	$cash/title/Label.text = globaldata.text["stats"]["cash"]
	$cash/Sign.text = globaldata.text["stats"]["dollarsign"]
