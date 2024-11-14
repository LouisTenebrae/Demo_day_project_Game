extends Node

var playerBody: CharacterBody2D
var playerDamageAmount = 5
var playerDamageZone: CollisionShape2D
var playerHitbox: CollisionShape2D

var slimeDamageZone: Area2D
var slimeDamageAmount: int

# Leveling Sys
var player_exp = 0
var player_level = 1
var exp_thresholds = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45]
