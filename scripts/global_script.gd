extends Node

var game_running = false
signal game_state(game_state: GameState)
signal update_score(score: String)
enum GameState {
	START,
	PAUSED,
	GAME_OVER
}
