/datum/team/nation
	name = "Nation"

/datum/antagonist/separatist
	name = "Separatists"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	var/datum/team/nation/nation

/datum/antagonist/separatist/create_team(datum/team/nation/new_team)
	if(!new_team)
		return
	nation = new_team

/datum/antagonist/separatist/get_team()
	return nation

/datum/antagonist/separatist/greet()
	to_chat(owner, "<B>Ты — сепаратист! [nation.name] навеки! Защищай независимость своей новой земли плечом к плечу с товарищами по оружию!</B>")
