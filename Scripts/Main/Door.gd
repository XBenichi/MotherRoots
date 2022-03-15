extends Area2D

export var targetX = 0
export var targetY = 0
export var targetScene = ""

var targetCutoff = 0
var currentState = 0
var player = null
var sameScene = false
var activeDoor = true

var fade = null


func _on_Door_body_entered(body):
	fade = uiManager.fade
	if activeDoor:
		if global.currentScene.get_name() == targetScene or targetScene == "":
			sameScene = true
		else:
			global.add_persistent(self)
		activeDoor = false
		player = body
		if player == global.persistPlayer:
			global.persistPlayer.pause()
			_fade_in()
			currentState = 1
	
func _process(delta):
	if currentState != 0:
		match currentState:
			1:
				if fade.material.get_shader_param("cutoff") != targetCutoff:
					pass
				else:
					currentState = 2
			2:
				if !sameScene:
					_change_scene()
				currentState = 3
			3:
				fade.material.set_shader_param("cutoff", 0)
				_move_player()
				currentState = 4
			4:
				_fade_out()
				currentState = 5
			5:
				if fade.material.get_shader_param("cutoff") != targetCutoff:
					pass
				else:
					player.unpause()
					if !sameScene:
						global.remove_persistent(self)
						queue_free()
					else:
						activeDoor = true
						currentState = 0

func _change_scene():
	global.goto_scene("res://Maps/" + targetScene + ".tscn")
		
func _move_player():
	player.position.x = targetX
	player.position.y = targetY

func _fade_in():
	targetCutoff = 0
	fade.fade_in()

func _fade_out():
	targetCutoff = 1
	fade.fade_out()


