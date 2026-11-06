/datum/surgery/advanced/bioware/ligament_hook
	name = "Связочный крюк"
	desc = "A surgical procedure which reshapes the connections between torso and limbs, making it so limbs can be attached manually if severed. \
	However this weakens the connection, making them easier to detach as well."
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/incise,
				/datum/surgery_step/reshape_ligaments,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	bioware_target = BIOWARE_LIGAMENTS

/datum/surgery_step/reshape_ligaments
	name = "придать форму связкам"
	accept_hand = TRUE
	time = 125

/datum/surgery_step/reshape_ligaments/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты начинаешь придавать связкам [target] форму крюка.</span>",
		"<span class='notice'>[user] начинает придавать связкам [target] форму крюка.</span>",
		"<span class='notice'>[user] начинает перебирать связки [target].</span>")

/datum/surgery_step/reshape_ligaments/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты переделываешь связки [target] в соединительный крюк!</span>",
		"<span class='notice'>[user] переделывает связки [target] в соединительный крюк!</span>",
		"<span class='notice'>[user] заканчивает перебирать связки [target].</span>")
	new /datum/bioware/hooked_ligaments(target)
	return TRUE

/datum/bioware/hooked_ligaments
	name = "Крючковидные связки"
	desc = ""
	mod_type = BIOWARE_LIGAMENTS

/datum/bioware/hooked_ligaments/on_gain()
	..()
	ADD_TRAIT(owner, TRAIT_LIMBATTACHMENT, "ligament_hook")
	ADD_TRAIT(owner, TRAIT_EASYDISMEMBER, "ligament_hook")

/datum/bioware/hooked_ligaments/on_lose()
	..()
	REMOVE_TRAIT(owner, TRAIT_LIMBATTACHMENT, "ligament_hook")
	REMOVE_TRAIT(owner, TRAIT_EASYDISMEMBER, "ligament_hook")
