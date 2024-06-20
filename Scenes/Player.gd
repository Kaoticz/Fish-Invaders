extends Area2D


@export var speed: int = 250 # Player movement speed, in pixels/sec.
var screen_size: Vector2 # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.screen_size = get_viewport_rect().size
	self.position.x = 70
	self.position.y = screen_size.y / 2
	$AnimatedSprite2D.play()
	#self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Stop the player from leaving the screen.
	self.position += velocity * delta
	self.position = self.position.clamp(Vector2.ZERO, screen_size)
