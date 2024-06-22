extends Area2D
## This class defines the torpedo's behavior.


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


## Triggered by the engine when any 2D body collides with the projectile.
## body: The body that collided with the projectile
func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("mobs"):
		return
	area.queue_free()
	self.queue_free()


## Despawns the torpedo when it goes out of the screen.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()
