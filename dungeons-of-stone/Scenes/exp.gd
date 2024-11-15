extends ProgressBar


func _ready() -> void:
	update_exp_bar()


func _process(delta: float) -> void:
	update_exp_bar()
	check_level_up()


func gain_exp(amount: int):
	if Global.player_level >= Global.player_max_level:
		Global.player_exp = 0
		return

	Global.player_exp += amount
	while Global.player_level < Global.player_max_level and Global.player_exp >= Global.exp_thresholds[Global.player_level]:
		Global.player_exp -= Global.exp_thresholds[Global.player_level]
		Global.player_level += 1
		
		# Stop further leveling if max level is reached
		if Global.player_level >= Global.player_max_level:
			Global.player_exp = 0
			return
	update_exp_bar()

func update_exp_bar():
	$".".max_value = Global.exp_thresholds[Global.player_level]
	$".".value = Global.player_exp

func check_level_up():
	while Global.player_level < Global.player_max_level and Global.player_exp >= Global.exp_thresholds[Global.player_level]:
		Global.player_exp -= Global.exp_thresholds[Global.player_level]
		Global.player_level += 1       
		# Stop leveling up if max level is reached
		if Global.player_level >= Global.player_max_level:
			Global.player_exp = 0 
			return
