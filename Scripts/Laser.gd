extends Area2D
## This class defines the laser's behavior.


## The speed of the projectile
var speed: int = 300

## The size of the game window.
var screen_size: Vector2


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	self.screen_size = get_viewport_rect().size


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position -= self.transform.x * speed * delta


## Triggered by the engine when any 2D body collides with the projectile.
## body: The body that collided with the projectile
func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("player"):
		return
	self.get_tree().get_nodes_in_group("mainmenu")[0].game_over()
	self.queue_free()


## Despawns the laser when it goes out of the screen.
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()
