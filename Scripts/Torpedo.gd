extends Area2D

## The speed of the projectile
var speed: int = 750


## The size of the game window.
var screen_size: Vector2


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	self.screen_size = get_viewport_rect().size


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position += self.transform.x * speed * delta
	if (self.position.x > screen_size.x || self.position.x < 0):
		self.queue_free()


## Triggered by the engine when any 2D body collides with the projectile.
## body: The body that collided with the projectile
func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("mobs"):
		return
	body.queue_free()
	self.queue_free()
