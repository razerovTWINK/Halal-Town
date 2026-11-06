
/datum/antagonist/prisoner
	name = "Prisoner"
	increase_votepwr = FALSE

/datum/antagonist/prisoner/on_gain()
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/escape/prisoner/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective
		return
//	ADD_TRAIT(owner.current, RTRAIT_ANTAG, TRAIT_GENERIC)
	return ..()

/datum/antagonist/prisoner/on_removal()
	return ..()


/datum/antagonist/prisoner/greet()
	owner.announce_objectives()
	..()

/datum/antagonist/prisoner/roundend_report()
	var/traitorwin = TRUE

	var/count = 0
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		for(var/datum/objective/objective in objectives)
			objective.update_explanation_text()
			if(!objective.check_completion())
				traitorwin = FALSE
			count++

	if(!count)
		count = 1

	if(traitorwin)
		owner.adjust_triumphs(count)
		to_chat(owner.current, "<span class='greentext'>Я СБЕЖАЛ ИЗ ЭТОЙ УЖАСНОЙ КАМЕРЫ! ВЕСЬ МИР У МОИХ НОГ!</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		if(considered_alive(owner))
			owner.adjust_triumphs(-2)
			to_chat(owner.current, "<span class='redtext'>МНЕ НИКОГДА НЕ СБЕЖАТЬ!!</span>")
		else
			to_chat(owner.current, "<span class='redtext'>Я спасся... лишь в СМЕРТИ!</span>")
		if(owner.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

