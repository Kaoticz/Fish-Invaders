extends Area2D
## This class defines the behavior of the mobs.


## Defines whether this mob got killed by a player torpedo or not.
@export var is_torpedoed: bool = false

## How many vertical movements the mobs have performed in a cycle.
var movements: int = 0

## Defines whether the mobs are moving upwards or downwards.
var going_down: bool = true


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


## Moves the mobs everytime the $MoveTimer ticks.
func _on_timer_timeout() -> void:
	if going_down && movements < 8:
		self.position.y += 30
		movements += 1
	elif !going_down && movements < 8:
		self.position.y -= 30
		movements += 1
	else:
		self.position.x -= 60
		going_down = !going_down
		movements = 0
		$MoveTimer.wait_time *= 0.9
