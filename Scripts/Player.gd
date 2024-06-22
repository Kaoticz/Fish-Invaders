extends Area2D
## This class defines the player's submarine controls and behaviors.


## An event that triggers when something colides with the player.
signal hit

## Player movement speed, in pixels/sec.
@export var speed: int = 250

## The torpedo scene.
var torpedo_scene: PackedScene = load("res://Scenes/Torpedo.tscn")

## The size of the game window.
var screen_size: Vector2

## The Unix time in seconds the last shot was fired.
var last_shot_at: float = Time.get_unix_time_from_system() - 2


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	self.start(Vector2(70, screen_size.y / 2))
	self.hide()


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("shoot") && Time.get_unix_time_from_system() - last_shot_at > 2:
		shoot()
		last_shot_at = Time.get_unix_time_from_system()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	# Stop the player from leaving the screen.
	self.position += velocity * delta
	self.position = self.position.clamp(Vector2.ZERO, screen_size)


## Triggered by the engine when any 2D area intersects with the player.
## area: The area that intersected with the player
func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("mobs"):
		return
	self.stop()
	area.queue_free() # Despawn the projectile that hit the player
	self.hit.emit() # Trigger the hit event


## Shows the player on the screen.
## pos: The position the player should spawn at.
func start(pos: Vector2) -> void:
	self.position = pos
	self.show()
	$AnimatedSprite2D.play()
	$HuskCollision.disabled = false
	$TowerCollision.disabled = false


## Removes the player from the screen.
func stop() -> void:
	$AnimatedSprite2D.stop() # Stop animating the player's sprite.
	self.hide() # Player disappears after being hit.
	# Disable collision, so it doesn't get triggered more than once.
	$HuskCollision.set_deferred("disabled", true)
	$TowerCollision.set_deferred("disabled", true)


## Shoots a torpedo projectile.
func shoot() -> void:
	var projectile: Area2D = torpedo_scene.instantiate()
	projectile.position = $TorpedoSpawnPoint.global_position
	self.owner.add_child(projectile)
	$TorpedoFiredSound.play()
