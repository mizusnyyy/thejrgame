extends Node2D
enum state { PLAYER_TURN, ENEMY_TURN, WAITING }
enum mode { RED,BLUE }
var current_state = state.ENEMY_TURN
var current_mode = mode.BLUE
var tp = 0
var enemy_hp=100
