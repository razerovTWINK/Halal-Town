/datum/antagonist/aspirant
	name = "Aspirant"
	roundend_category = "aspirant"
	antagpanel_category = "Aspirant"
	job_rank = ROLE_ASPIRANT
	show_in_roundend = FALSE
	confess_lines = list("ИЗБРАННЫЙ ДОЛЖЕН ЗАНЯТЬ ТРОН!")
	increase_votepwr = FALSE

/datum/antagonist/aspirant/supporter
	name = "Supporter"

/datum/antagonist/aspirant/loyalist
	name = "Loyalist"

/datum/antagonist/aspirant/ruler
	name = "Ruler"

/datum/antagonist/aspirant/on_gain()
	. = ..()
	owner.special_role = ROLE_ASPIRANT
	var/mob/living/carbon/human/H = owner.current
	H.cmode_music = 'sound/music/combatbandit.ogg'

/datum/antagonist/aspirant/greet()
	to_chat(owner, "<span class='danger'>Мне надоело быть рядом с троном, но не на нём. Пришло время мне править Энигмой.</span>")
	..()

/datum/antagonist/aspirant/loyalist/greet()
	to_chat(owner, "<span class='danger'>Да здравствует Король! Я предан своему правителю. Но до меня дошли слухи о заговоре. Я не позволю свергнуть его.</span>")

/datum/antagonist/aspirant/supporter/greet()
	to_chat(owner, "<span class='danger'>Да здравствует Король! Но не нынешний. Претендент открыл мне глаза, и я встал под его знамена. Я помогу ему взойти на трон.</span>")

/datum/antagonist/aspirant/ruler/greet() // No alert for the ruler to always keep them guessing.

/datum/antagonist/prebel/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(.)
		if(!new_owner.assigned_role in GLOB.noble_positions || !new_owner.assigned_role in GLOB.garrison_positions)
			return FALSE

/datum/antagonist/aspirant/on_gain()
	. = ..()
	create_objectives()
	if(istype(src, /datum/antagonist/aspirant/ruler))
		return
	owner.announce_objectives()

/datum/antagonist/aspirant/on_removal()
	remove_objectives()
	. = ..()

/datum/antagonist/aspirant/proc/create_objectives()
	if(istype(src, /datum/antagonist/aspirant/ruler))
		var/datum/objective/aspirant/loyal/one/G = new
		objectives += G
		return
	if(istype(src, /datum/antagonist/aspirant/loyalist))
		var/datum/objective/aspirant/loyal/two/G = new
		objectives += G
		G.initialruler = SSticker.rulermob
		return
	if(istype(src, /datum/antagonist/aspirant/supporter))
		var/datum/game_mode/chaosmode/C = SSticker.mode
		var/datum/objective/aspirant/coup/three/G = new
		objectives += G
		for(var/datum/mind/aspirant in C.aspirants)
			if(aspirant.special_role == "Aspirant")
				G.aspirant = aspirant.current
		return
	else
		var/datum/objective/aspirant/coup/one/G = new
		objectives += G
		if(prob(50))
			var/datum/objective/aspirant/coup/two/M = new
			objectives += M
			M.initialruler = SSticker.rulermob


/datum/antagonist/aspirant/proc/remove_objectives()

// OBJECTIVES
/datum/objective/aspirant/coup/one
	name = "Aspirant"
	explanation_text = "Я должен короноваться монархом."
	triumph_count = 5

/datum/objective/aspirant/coup/one/check_completion()
	if(owner.current == SSticker.rulermob)
		return TRUE
	else
		return FALSE

/datum/objective/aspirant/coup/two
	name = "Moral"
	explanation_text = "Я не братоубийца, я должен проследить, чтобы монарх остался жив."
	triumph_count = 10
	var/initialruler

/datum/objective/aspirant/coup/three
	name = "Hopeful"
	explanation_text = "Я должен посадить Претендента на трон."
	var/aspirant

/datum/objective/aspirant/coup/two/check_completion()
	var/mob/living/carbon/human/kin = initialruler
	if(!initialruler)
		return FALSE
	if(!kin.stat)
		return TRUE
	else return FALSE

/datum/objective/aspirant/loyal/one
	name = "Ruler"
	explanation_text = "Я должен удержать корону."
	triumph_count = 3

/datum/objective/aspirant/loyal/one/check_completion()
	if(owner.current == SSticker.rulermob)
		return TRUE
	else
		return FALSE

/datum/objective/aspirant/loyal/two
	name = "Loyalist"
	explanation_text = "Я должен защитить правление законного монарха."
	triumph_count = 3
	var/initialruler

/datum/objective/aspirant/loyal/two/check_completion()
	if(!initialruler)
		return FALSE
	if(SSticker.rulermob == initialruler)
		return TRUE
	else return FALSE

/datum/antagonist/aspirant/roundend_report()
	to_chat(world, "<span class='header'> * [name] * </span>")

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(world, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(world, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>ПРОВАЛ.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(world, "<span class='greentext'>Претендент взошёл на трон! УСПЕХ!</span>")
		else
			to_chat(world, "<span class='redtext'>Претендент потерпел поражение! ПРОВАЛ!</span>")

/datum/antagonist/aspirant/ruler/roundend_report()
	to_chat(owner, "<span class='header'> * [name] * </span>")

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(owner, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(owner, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>ПРОВАЛ.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(owner, "<span class='greentext'>Ты отстоял свой трон! УСПЕХ!</span>")
		else
			to_chat(owner, "<span class='redtext'>Тебя свергли с трона! ПРОВАЛ!</span>")

/datum/antagonist/aspirant/supporter/roundend_report()
	to_chat(owner, "<span class='header'> * [name] * </span>")

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(owner, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(owner, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>ПРОВАЛ.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(owner, "<span class='greentext'>Твой избранник занял трон! УСПЕХ!</span>")
		else
			to_chat(owner, "<span class='redtext'>Твой избранник потерпел неудачу! ПРОВАЛ!</span>")

/datum/antagonist/aspirant/loyalist/roundend_report()
	to_chat(owner, "<span class='header'> * [name] * </span>")

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(owner, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>ТРИУМФ!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(owner, "<B>Цель #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>ПРОВАЛ.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(owner, "<span class='greentext'>Твой правитель удержал трон! УСПЕХ!</span>")
		else
			to_chat(owner, "<span class='redtext'>Твой правитель был свергнут! ПРОВАЛ!</span>")
