extends Node2D

var party =  []
var partySpace = []
var partySize: int = 100
var nintenInv = []
var lloyd_teddyInv = []
var anaInv = []
var persistArray = []
var partyObjects = []
var currentScene = null
var persistPlayer = null
var dialogue_box_template = null
var followerTemplate = load("res://Nodes/Reusables/PartyFollower.tscn")
var debugMenu = load("res://Nodes/Ui/debug/debug.tscn")
var maxInventorySlots = 10
var boostable_stats = ['speed', 'offense', 'defense', 'guts', 'luck', 'vitality', 'iq']
var dialogue = ""

func _ready():
	set_dialog("noproblem")
	partySpace.resize(partySize)
	var root = get_tree().get_root()
	
	currentScene = root.get_child(root.get_child_count() - 1)
	if persistPlayer == null:
		party.append({"name": "Ninten", "status": globaldata.ailments.Normal, "lvl": 42, "exp": 0, "hp": 600, "maxhp": 999, "pp": 46, "maxpp": 999, "speed": 99, "offense": 25, "defense": 25, "iq": 25, "guts": 25, "pronouns": "his", "active": true})
		party.append({"name": "Lloyd", "status": globaldata.ailments.Normal, "lvl": 42, "exp": 0,  "hp": 400, "maxhp": 999, "pp": 0, "maxpp": 0, "speed": 14, "offense": 55, "defense": 25, "iq": 25, "guts": 25, "pronouns": "his", "active": false})
		party.append({"name": "Ana", "status": globaldata.ailments.Unconcious, "lvl": 42, "exp": 0,  "hp": 0, "maxhp": 999, "pp": 43, "maxpp": 999, "speed": 13, "offense": 60, "defense ": 25, "iq": 25, "guts": 25, "pronouns": "her", "active": false})
		party.append({"name": "Teddy", "status": globaldata.ailments.Unconcious, "lvl": 42, "exp": 0,  "hp": 0, "maxhp": 999, "pp": 43, "maxpp": 0, "speed": 12, "offense": 32, "defense": 25, "iq": 25, "guts": 25, "pronouns": "his", "active": false})
		party.append({"name": "Pippi", "status": globaldata.ailments.Normal, "lvl": 42, "exp": 0,  "hp": 600, "maxhp": 999, "pp": 0, "maxpp": 0, "speed": 99, "offense": 25, "defense": 25, "iq": 25, "guts": 25, "pronouns": "her", "active": false})
		
		var playerTemplate = load("res://Nodes/Reusables/Player.tscn")
		var player = playerTemplate.instance()
		player.set_name("player")
		currentScene.get_node("YSort").add_child(player)
		persistPlayer = player
		player.position.x = 0
		player.position.y = 0
		create_party_followers()
	
	if dialogue_box_template == null:
		dialogue_box_template = load("res://Nodes/Ui/DialogueBox.tscn")

func _process(delta):
	if OS.is_debug_build():
		if Input.is_action_just_pressed("ui_backtick"):
			if uiManager.uiStack.size() == 0:
				var dm = debugMenu.instance()
				uiManager.add_ui(dm)
	if Input.is_action_just_pressed("ui_accept"):
		if uiManager.uiStack.size() == 0:
			if currentScene.get_name() != "Title screen":
				uiManager.open_commands_menu()
	

func add_persistent(node_to_persist):
	persistArray.append(node_to_persist)

func remove_persistent(node_to_remove):
	persistArray.erase(node_to_remove)

func goto_scene(path):
	
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# Store the player
	currentScene.get_node("YSort").remove_child(persistPlayer)
	# Remove all the children from the current node that we are going to keep
	for node in persistArray:
		if node != null:
			node.get_parent().remove_child(node)
	
	# It is now safe to remove the current scene
	currentScene.free()
	
	# Load the new scene.
	var scene = ResourceLoader.load(path)
	
	# Instance the new scene.
	currentScene = scene.instance()
	#play_location_music()
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(currentScene)
	
	# Bring over the player
	currentScene.get_node("YSort").add_child(persistPlayer)
	
	# Create the party followers
	create_party_followers()
	
	# load over persistent nodes
	for node in persistArray:
		currentScene.add_child(node)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(currentScene)

func get_active_players():
	var active = 0
	for player in party:
		if player['active']:
			active += 1
	return active
	
func get_active_players_list():
	var active = []
	for player in party:
		if player['active']:
			active.append(player)
	return active
	
func get_active_player_indexes():
	var active = []
	for i in range(party.size()):
		if party[i]['active']:
			active.append(i)
	return active
	
func create_party_followers():
	# This function creates the party members following the main player in the
	# overworld
	var active = get_active_players_list()
	if partyObjects.size() > 1:
		for i in range(partyObjects.size()):
			if partyObjects[i] != persistPlayer and is_instance_valid(partyObjects[i]):
				partyObjects[i].queue_free()
		partyObjects.clear()
		partyObjects.append(persistPlayer)
	for i in range(active.size() - 1):
		var follow = followerTemplate.instance()
		follow.spacing = i * 15 + 14
		follow.delay = i * 0.2 + 0.2  
		partyObjects.append(follow)
		currentScene.get_node("YSort").add_child(follow)
		if active[i+1]["status"] == globaldata.ailments.Normal:
			follow.sprite.texture = load("res://Graphics/Character Sprites/" + active[i+1]['name'] + "/main.png")
		elif active[i+1]["status"] == globaldata.ailments.Unconcious:
			follow.sprite.texture = load("res://Graphics/Character Sprites/" + active[i+1]['name'] + "/dead.png")

func set_dialog(path):
	dialogue = "res://Data/Dialogue/" + path +".json"
	
