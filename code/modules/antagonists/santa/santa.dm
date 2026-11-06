/datum/antagonist/santa
	name = "Santa"
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE

/datum/antagonist/santa/on_gain()
	. = ..()
	give_equipment()
	give_objective()

	ADD_TRAIT(owner, TRAIT_CANNOT_OPEN_PRESENTS, TRAIT_SANTA)
	ADD_TRAIT(owner, TRAIT_PRESENT_VISION, TRAIT_SANTA)

/datum/antagonist/santa/greet()
	. = ..()
	to_chat(owner, "<span class='boldannounce'>Ты — Санта! Твоя цель — нести радость людям. У тебя есть волшебный мешок, создающий подарки, пока он при тебе! Осматривай подарки, чтобы заглянуть внутрь и вручить нужный подарок правильному человеку.</span>")

/datum/antagonist/santa/proc/give_equipment()
	var/mob/living/carbon/human/H = owner.current
	if(istype(H))
		H.equipOutfit(/datum/outfit/santa)
		H.dna.update_dna_identity()

	owner.AddSpell(new /obj/effect/proc_holder/spell/targeted/area_teleport/teleport/santa)

/datum/antagonist/santa/proc/give_objective()
	var/datum/objective/santa_objective = new()
	santa_objective.explanation_text = "Bring joy and presents to the station!"
	santa_objective.completed = TRUE //lets cut our santas some slack.
	santa_objective.owner = owner
	objectives |= santa_objective
