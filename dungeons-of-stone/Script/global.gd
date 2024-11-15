extends Node

var playerBody: CharacterBody2D
var playerDamageAmount = 5
var playerDamageZone: CollisionShape2D
var playerHitbox: CollisionShape2D

var slimeDamageZone: Area2D
var slimeDamageAmount: int

# Leveling system
var player_exp = 0
var player_level = 1
var player_max_level = 10
var exp_thresholds = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 1]
