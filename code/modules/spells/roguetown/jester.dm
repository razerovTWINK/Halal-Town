/obj/effect/proc_holder/spell/self/telljoke
	name = "Комедия"
	desc = "Скажи что-нибудь смешное тому, кто в хорошем настроении, чтобы приободрить его ещё сильнее."
	overlay_state = "comedy"
	antimagic_allowed = TRUE
	invocation_type = "shout"
	charge_max = 600

/obj/effect/proc_holder/spell/self/telljoke/cast(list/targets,mob/user = usr)
	..()
	var/joker = input(user, "Скажи что-нибудь смешное!", "Комедия")
	if(!joker)
		return FALSE
	user.say(joker, forced = "spell")
	sleep(20)
	playsound(get_turf(user), 'sound/magic/comedy.ogg', 100)
	for(var/mob/living/carbon/CA in view(7, get_turf(user)))
		if(CA == user)
			continue
		if(CA.cmode)
			continue
		if(CA.stress <= 0)
			CA.add_stress(/datum/stressevent/joke)
			CA.emote(pick("laugh","chuckle","giggle"), forced = TRUE)
		sleep(rand(1,5))

/obj/effect/proc_holder/spell/self/telltragedy
	name = "Трагедия"
	desc = "Напомни тому, кто пал духом, что всё могло быть намного хуже."
	overlay_state = "tragedy"
	antimagic_allowed = TRUE
	invocation_type = "shout"
	charge_max = 600

/obj/effect/proc_holder/spell/self/telltragedy/cast(list/targets,mob/user = usr)
	..()
	var/joker = input(user, "Скажи что-нибудь грустное!", "Трагедия")
	if(!joker)
		return FALSE
	user.say(joker, forced = "spell")
	sleep(20)
	playsound(get_turf(user), 'sound/magic/tragedy.ogg', 100)
	for(var/mob/living/carbon/CA in view(7, get_turf(user)))
		if(CA == user)
			continue
		if(CA.cmode)
			continue
		if(CA.stress > 0)
			CA.add_stress(/datum/stressevent/tragedy)
			CA.emote(pick("sigh","hmm"), forced = TRUE)
		sleep(rand(1,5))