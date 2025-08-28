extends Node

var game_running = false

enum GameState {
	START,
	PAUSED,
	GAME_OVER
}

signal game_state(game_state: GameState)
