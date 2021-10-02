extends Node

#ACHIEVMENTS
var explorer_achievment = 'CgkIzLv_krASEAIQAg'
var begginer_achievment = 'CgkIzLv_krASEAIQAw'
var early_man_achievment = 'CgkIzLv_krASEAIQBA'
var first_time_achievment = 'CgkIzLv_krASEAIQBQ'
var gatherer_achievment = 'CgkIzLv_krASEAIQBg'
var pharaon_achievment = 'CgkIzLv_krASEAIQCA'
var rich_achievment = 'CgkIzLv_krASEAIQCQ'
var rockefeller_achievment = 'CgkIzLv_krASEAIQCg'
var tarzan_achievement = 'CgkIzLv_krASEAIQCw'
var valuable_achievement = 'CgkIzLv_krASEAIQDA'

func show_achievements():
	if OS.get_name() == "Android":
		PlayIntegration.play_services.showAchievements()

func _player_die_state():
	if OS.get_name() == "Android":
		PlayIntegration.play_services.unlockAchievement(first_time_achievment)

func _map_state():
	if OS.get_name() == "Android":
		PlayIntegration.play_services.unlockAchievement(explorer_achievment)

func _level_completed_state(level_number):
	if OS.get_name() == "Android":
		var score = check_extra_number()
		update_extra_achievements(score)
		submit_score(score)
		
		if level_number >= 1:
			PlayIntegration.play_services.unlockAchievement(begginer_achievment)
		elif level_number >= 20:
			PlayIntegration.play_services.unlockAchievement(early_man_achievment)	
		elif level_number >= 40:
			PlayIntegration.play_services.unlockAchievement(pharaon_achievment)	
		elif level_number >= 60:
			PlayIntegration.play_services.unlockAchievement(tarzan_achievement)	
		
func _extra_picked_state():
	if OS.get_name() == "Android":
		PlayIntegration.play_services.unlockAchievement(gatherer_achievment)
	
func check_extra_number():
	var extra_counter: = 0
	
	for x in GameDataManager.level_info.size() - 1:
		if GameDataManager.level_info[x + 1].has("extra_unlocked"):
			if GameDataManager.level_info[x + 1]["extra_unlocked"] == true:
				extra_counter += 1
				
	return extra_counter
	
func update_extra_achievements(score):
	PlayIntegration.play_services.setAchievementSteps(rich_achievment, score)
	PlayIntegration.play_services.setAchievementSteps(rockefeller_achievment, score)
	PlayIntegration.play_services.setAchievementSteps(valuable_achievement, score)
	
#LEADERBOARD
const leaderboardID = "CgkIzLv_krASEAIQBw"

func show_leaderboard():
	if OS.get_name() == "Android":
		PlayIntegration.play_services.showLeaderBoard(leaderboardID)
	
func submit_score(score : int):
	if OS.get_name() == "Android":
		PlayIntegration.play_services.submitLeaderBoardScore(leaderboardID, score)

