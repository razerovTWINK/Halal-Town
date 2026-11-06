/obj/effect/proc_holder/spell/targeted/personality_commune
	name = "Общение личностей"
	desc = ""
	charge_max = 0
	clothes_req = FALSE
	range = -1
	include_user = TRUE
	action_icon_state = "telepathy"
	action_background_icon_state = "bg_spell"
	var/datum/brain_trauma/severe/split_personality/trauma
	var/flufftext = "Ты слышишь отдающийся эхом голос на задворках сознания..."

/obj/effect/proc_holder/spell/targeted/personality_commune/New(datum/brain_trauma/severe/split_personality/T)
	. = ..()
	trauma = T

// Pillaged and adapted from telepathy code
/obj/effect/proc_holder/spell/targeted/personality_commune/cast(list/targets, mob/user)
	if(!istype(trauma))
		to_chat(user, "<span class='warning'>Что-то не так: у тебя нет расщепления личности!</span>")
		return
	var/msg = stripped_input(usr, "Что сказать второй личности?", null , "")
	if(!msg)
		charge_counter = charge_max
		return
	to_chat(user, "<span class='boldnotice'>Ты концентрируешься и посылаешь мысли второй личности:</span> <span class='notice'>[msg]</span>")
	to_chat(trauma.owner, "<span class='boldnotice'>[flufftext]</span> <span class='notice'>[msg]</span>")
	log_directed_talk(user, trauma.owner, msg, LOG_SAY ,"[name]")
	for(var/ded in GLOB.dead_mob_list)
		if(!isobserver(ded))
			continue
		to_chat(ded, "[FOLLOW_LINK(ded, user)] <span class='boldnotice'>[user] [name]:</span> <span class='notice'>\"[msg]\" to</span> <span class='name'>[trauma]</span>")
