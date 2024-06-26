extends Area2D
## This class defines the behavior of the mobs.


## Defines whether this mob got killed by a player torpedo or not.
@export var is_torpedoed: bool = false

## The laser scene.
var laser_scene: PackedScene = load("res://Scenes/Laser.tscn")

## How many vertical movements the mobs have performed in a cycle.
var movements: int = 0

## Defines whether the mobs are moving upwards or downwards.
var going_down: bool = true

## The position the mob should lerp to.
var target_position: Vector2


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	target_position = self.position
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = self.position.lerp(target_position, delta * 3)


## Moves the mobs everytime the $MoveTimer ticks.
func _on_timer_timeout() -> void:
	if going_down && movements < 8:
		target_position = Vector2(target_position.x, target_position.y + 30)
		movements += 1
	elif !going_down && movements < 8:
		target_position = Vector2(target_position.x, target_position.y - 30)
		movements += 1
	else:
		target_position = Vector2(target_position.x - 60, target_position.y)
		going_down = !going_down
		movements = 0
		$MoveTimer.wait_time *= 0.9
	
	if randi() % 101 < 10:
		var projectile: Area2D = laser_scene.instantiate()
		projectile.position = $LaserSpawnPoint.global_position
		self.get_tree().current_scene.add_child(projectile)
