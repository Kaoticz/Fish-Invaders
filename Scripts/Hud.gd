extends CanvasLayer
## This class defines the behavior of the HUD.


## This event is triggered when the Start button is pressed.
signal start_game


## Start method, called when this node enters the scene tree for the first time.
func _ready() -> void:
	pass


## Update method, runs on every frame.
## delta: The elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


## Shows a message on the HUD.
## text: the message to be displayed.
func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


## Stops the gameplay and returns to the main menu.
func show_game_end(text: String) -> void:
	show_message(text)
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Fish Invaders"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


## Triggered when the start button is pressed.
func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


## Hides the message after the game has started.
func _on_message_timer_timeout() -> void:
	$Message.hide()
