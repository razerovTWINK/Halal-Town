
/datum/antagonist/purishep
	name = "purishep"
	increase_votepwr = FALSE

/datum/antagonist/purishep/on_gain()
	if(!(locate(/datum/objective/purishep) in objectives))
		var/datum/objective/purishep/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective
		return
	return ..()

/datum/antagonist/purishep/on_removal()
	return ..()


/datum/antagonist/purishep/greet()
	owner.announce_objectives()
	..()

/datum/objective/purishep
	explanation_text = "Отправить 5 признаний в грехах Инквизиции в Кингсфилде."

/datum/objective/purishep/check_completion()
	if(GLOB.confessors)
		if(GLOB.confessors.len >= 5)
			return TRUE

/datum/antagonist/purishep/roundend_report()
	var/traitorwin = TRUE

	if(objectives.len)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				traitorwin = FALSE
	if(considered_alive(owner))
		if(traitorwin)
			to_chat(owner.current, "<span class='greentext'>5/5.</span>")
		else
			to_chat(owner.current, "<span class='redtext'>Я НЕ СПРАВИЛСЯ со своей задачей. Мне на смену придёт кто-то более способный.</span>")