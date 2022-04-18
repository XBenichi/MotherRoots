extends KinematicBody2D


var inputVector  = Vector2.ZERO
var velocity = Vector2.ZERO
var speed: int = 64
var walk


onready var sprite = $main
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var cutsceneAnimator = $CutsceneAnimation 
onready var animationState = animationTree.get("parameters/playback")
onready var eventRayCaster = $EventDetector

export (int) var spriteSize_X = 10
export (int) var spriteSize_Y = 10
export (bool) var paused = false

func _ready():
	pass

# warning-ignore:unused_argument
func _physics_process(delta):
	if !paused:
		_controls()
		_movement()
	else:
		animationState.travel("Idle")
	_spritesheet()

	


func _controls():
	var up = Input.get_action_strength("ui_up")
	var down = Input.get_action_strength("ui_down")
	var left = Input.get_action_strength("ui_left")
	var right = Input.get_action_strength("ui_right")
	inputVector.x = int(right) - int(left)
	inputVector.y = int(down) - int(up)
	
	

func _movement():
	if inputVector != Vector2.ZERO:
		velocity = inputVector * speed
		
		if global.party.size() != 1:
			global.partySpace.push_front(self.position)
			global.partySpace.pop_back()
		
		animationTree.set("parameters/Idle/blend_position", inputVector)
		animationTree.set("parameters/Walk/blend_position", inputVector)
		animationState.travel("Walk")
		
		if Input.is_action_pressed("ui_cancel"):
			speed = 96
			animationTree.advance(1 * get_physics_process_delta_time())
			#animationTree.set("parameters/BlendTree/TimeScale/scale", 5.0)
		else:
			speed = 64
			#animationTree.set("parameters/BlendTree/TimeScale/scale", 1.0)
		
		walk = true
		
		eventRayCaster.rotation = inputVector.angle() - TAU/4
	else:
		velocity = Vector2.ZERO
		walk = false
		animationState.travel("Idle")
	velocity = move_and_slide(velocity)
	self.position.x = round(self.position.x)
	self.position.y = round(self.position.y)

func _spritesheet():
	match(global.party[0]):
		"ninten":
			sprite.texture = load("res://Graphics/Character Sprites/Ninten/main.png")
		"lloyd":
			sprite.texture = load("res://Graphics/Character Sprites/Lloyd/main.png")
		"ana":
			sprite.texture = load("res://Graphics/Character Sprites/Ana/main.png")
		

func pause():
	paused = true
	animationTree.active = false

func unpause():
	paused = false
	animationTree.active = true
