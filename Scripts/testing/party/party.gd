extends KinematicBody2D

var inputVector = Vector2.ZERO
export (int) var spacing = 20
var delay = 0.2

onready var sprite = $main
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _process(delta):
	if global.partySpace[spacing] != null:
		self.position = global.partySpace[spacing]
		var player = global.persistPlayer
		$Timer.wait_time = delay
		if player.walk == true:
			inputVector = position.direction_to(global.partySpace[spacing - 1])
			animationTree.set("parameters/Idle/blend_position", inputVector)
			animationTree.set("parameters/Walk/blend_position", inputVector)
			animationState.travel("Walk")
			if Input.is_action_pressed("ui_cancel"):
				animationTree.advance(1 * delta)
		else:
			animationState.travel("Idle")
		if player.paused:
			animationState.travel("Idle")

func _on_Timer_timeout():
	if global.persistPlayer.walk == true:
		inputVector = global.persistPlayer.inputVector
