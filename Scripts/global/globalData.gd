extends Node

var cash: int = 0
var battleEnemySprites = [1]
var names = ["Ninten","Lloyd","Ana","Teddy"]
onready var text = {}

var flags = {
	##################
	#melodies
	##################
	"doll_melody": true,
	"canary_melody": false,
	"zoo_melody": false,
	"piano_melody": false,
	"cactus_melody": false,
	"dragon_melody": false,
	"eve_melody": false,
	"grave_melody": false,
	
	##################
	"debug_present": false,
	##################
	
	##################
	#ninten's house
	##################
	"lamp defeated": false,
	"doll defeated": false,
	##################
	#podunk
	##################
	"pippi_recused": false
}

enum ailments {Normal,Asthma,Crying,Burned,Cold,Confused,Forgetful,Nausea,Numb,Poisoned,Sleeping,Solidfied,Stone,Sunstroked,Unconcious}

func _ready():
	load_text()

func load_text():
	var file = File.new();
	var json = "res://Data/Menus/Menutexts.json"
	file.open(json, File.READ);
	text = parse_json(file.get_as_text())
	file.close()
