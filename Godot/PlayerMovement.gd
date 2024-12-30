extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
var inverted_sprite = false

@export var speed = 300.0
@export var jump_height = -500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_height

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * speed
		
		if Input.is_action_just_pressed("left"):
			sprite.flip_h = true
		elif  Input.is_action_just_pressed("right"):
			sprite.flip_h = false
		
		animation.play("Walking")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animation.stop()

	move_and_slide()
