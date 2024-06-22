extends Node
## This class defines the behavior of the main game scene.


## The mob scene.
var mob_scene: PackedScene = load("res://Scenes/Mob.tscn")

## The initial position of the mobs.
var mob_positions: Array[Vector2] = [
	Vector2(800, 50),
	Vector2(800, 125),
	Vector2(800, 200),
	Vector2(800, 275),
	Vector2(800, 350),
	Vector2(900, 50),
	Vector2(900, 125),
	Vector2(900, 200),
	Vector2(900, 275),
	Vector2(900, 350),
	Vector2(1000, 50),
	Vector2(1000, 125),
	Vector2(1000, 200),
	Vector2(1000, 275),
	Vector2(1000, 350),
	Vector2(1100, 50),
	Vector2(1100, 125),
	Vector2(1100, 200),
	Vector2(1100, 275),
	Vector2(1100, 350),
	Vector2(1200, 50),
	Vector2(1200, 125),
	Vector2(1200, 200),
	Vector2(1200, 275),
	Vector2(1200, 350)
]

## The amount of mobs still alive.
var mob_count: int = mob_positions.size()


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	pass


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


## Stops gameplay, shows game-over screen and returns to the main menu.
func game_over():
	$Player.stop()
	$Hud.show_game_end("Game Over")
	self.get_tree().call_group("mobs", "queue_free")
	mob_count = mob_positions.size()


## Initializes a new game session.
func new_game():
	$Player.start(Vector2(70, 200))
	$Player.show()
	$StartTimer.start()
	$Hud.show_message("Get Ready")


## Spawns the mobs when the $MessageTimer ticks.
func _on_start_timer_timeout() -> void:
	for position in mob_positions:
		var mob = mob_scene.instantiate()
		mob.position = position
		self.add_child(mob)


## Counts the amount of mobs killed by the player and triggers victory once all mobs have been killed.
## node: The game object that was removed from the renderer tree.
func _on_child_exiting_tree(node: Node) -> void:
	if !node.is_in_group("mobs") || !node.is_torpedoed:
		return
	mob_count -= 1
	
	if mob_count == 0:
		mob_count = mob_positions.size()
		$Player.stop()
		$Hud.show_game_end("Congratulations, you won!")
