extends CanvasLayer

onready var partyTemplate = load("res://Nodes/Ui/Battle/Partystatus.tscn")
onready var enemySprites = globaldata.battleEnemySprites
var enemySprite = load("res://Nodes/Ui/Battle/EnemySprite.tscn")
var battleEnemies = []
var enemysize = {}
var active = global.get_active_players_list()

func _ready():
	#add_enemy("Giegue Capsule", null)
	#add_enemy("R7038XX", null)
	add_enemy("TEST", null)
	add_enemy("Elephant", null)
	add_enemy("Lamp", null)
	draw_battle_enemies()



func _process(delta):
	uiManager.commandsMenuActive = false
	if Input.is_action_just_pressed("ui_home"):
		lose()
		global.persistPlayer.unpause()
		uiManager.commandsMenuActive = true


func update_party():
	for i in range(active.size()):
		var party = partyTemplate.instance()
		party.set_name("partystatus" + var2str(i))
		get_node("Status card/PartyContainer").add_child(party)
		party.partyname.text = active[i]["name"]
		party.status.text = globaldata.ailments.keys()[active[i]["status"]]
		party.hp.text = var2str(active[i]["hp"])
		party.pp.text = var2str(active[i]["pp"])
			

func draw_battle_enemies():
	var xInterval = 320 / (battleEnemies.size() + 1)
	var xPos = 0
	var yPos = 0
	var giegueSpriteTemplate = load("res://Nodes/Ui/Battle/Giegue.tscn")
	var giegueSprite = giegueSpriteTemplate.instance()
	
	enemySprites.clear()
	
	for i in range(battleEnemies.size()):
		xPos += xInterval
		var sprite = load("res://Graphics/Battle Sprites/" + battleEnemies[i]["name"] + ".png") #battleEnemies["enemyName"]
		var texture = enemySprite.instance()
		texture.texture = sprite

		if "R703" in battleEnemies[i]["name"]:
			yPos = 180 * 0.5 + texture.texture.get_height() / 2.2
		else:
			yPos = 180 * 0.5 + texture.texture.get_height() / 3
	
		get_node("enemies").add_child(texture)
		
		if "Giegue" in battleEnemies[i]["name"]:
			texture.add_child(giegueSprite)
		
		var texture_offset = Vector2(texture.rect_size.x / 2.0, texture.rect_size.y)
		texture.rect_position = Vector2(xPos, yPos) - texture_offset
		enemySprites.append(texture)

func bash():
	pass

func PSI():
	pass

func goods():
	pass

func check():
	pass

func magnifying_glass():
	pass

func guard():
	pass

func flee():
	pass

func win():
	pass

func lose():
	uiManager.remove_ui(self)

func load_enemy(enemy):
	var file = File.new();
	var json = "res://Data/Battlers/" + enemy + ".json"
	file.open(json, File.READ);
	enemy = parse_json(file.get_as_text())
	file.close()

func add_enemy(enemyName, overworld_object):
	battleEnemies.append({
		"name": enemyName,
	})


