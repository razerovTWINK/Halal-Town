/datum/surgery/advanced/revival
	name = "Оживление"
	desc = ""
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/saw,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/incise,
				/datum/surgery_step/revive,
				/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = 0

/datum/surgery/advanced/revival/can_start(mob/user, mob/living/carbon/target)
	if(!..())
		return FALSE
	if(target.stat != DEAD)
		return FALSE
	if(target.suiciding || target.hellbound || HAS_TRAIT(target, TRAIT_HUSK))
		return FALSE
	var/obj/item/organ/brain/B = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!B)
		return FALSE
	return TRUE

/datum/surgery_step/revive
	name = "ударить током"
	implements = list(/obj/item/twohanded/shockpaddles = 100, /obj/item/melee/baton = 75, /obj/item/gun/energy = 60)
	repeatable = TRUE
	time = 120

/datum/surgery_step/revive/tool_check(mob/user, obj/item/tool)
	. = TRUE
	if(istype(tool, /obj/item/twohanded/shockpaddles))
		var/obj/item/twohanded/shockpaddles/S = tool
		if((S.req_defib && !S.defib.powered) || !S.wielded || S.cooldown || S.busy)
			to_chat(user, "<span class='warning'>Нужно взять оба электрода в руки, а [S.defib] должен быть включён!</span>")
			return FALSE
	if(istype(tool, /obj/item/melee/baton))
		var/obj/item/melee/baton/B = tool
		if(!B.status)
			to_chat(user, "<span class='warning'>[B] должен быть включён!</span>")
			return FALSE
	if(istype(tool, /obj/item/gun/energy))
		var/obj/item/gun/energy/E = tool
		if(E.chambered && istype(E.chambered, /obj/item/ammo_casing/energy/electrode))
			return TRUE
		else
			to_chat(user, "<span class='warning'>Для этого нужен электрод!</span>")
			return FALSE

/datum/surgery_step/revive/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты готовишься вдохнуть искру жизни в мозг [target] с помощью [tool].</span>",
		"<span class='notice'>[user] готовится дать разряд в мозг [target] с помощью [tool].</span>",
		"<span class='notice'>[user] готовится дать разряд в мозг [target] с помощью [tool].</span>")
	target.notify_ghost_cloning("Кто-то пытается оживить твой мозг разрядом. Вернись в тело, если хочешь воскреснуть!", source = target)

/datum/surgery_step/revive/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты пускаешь разряд в мозг [target] с помощью [tool]...</span>",
		"<span class='notice'>[user] пускает мощный разряд в мозг [target] с помощью [tool]...</span>",
		"<span class='notice'>[user] пускает мощный разряд в мозг [target] с помощью [tool]...</span>")
	playsound(get_turf(target), 'sound/blank.ogg', 50, TRUE)
	target.adjustOxyLoss(-50, 0)
	target.updatehealth()
	if(target.revive(full_heal = FALSE, admin_revive = FALSE))
		target.visible_message("<span class='notice'>...[target] приходит в себя, снова живой и в сознании!</span>")
		target.emote("breathgasp")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 50, 199) //MAD SCIENCE
		return TRUE
	else
		target.visible_message("<span class='warning'>...[target] вздрагивает в судороге и затихает.</span>")
		return FALSE

/datum/surgery_step/revive/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>Ты бьёшь мозг [target] током с помощью [tool], но реакции нет.</span>",
		"<span class='notice'>[user] бьёт мозг [target] мощным разрядом с помощью [tool], но реакции нет.</span>",
		"<span class='notice'>[user] бьёт мозг [target] мощным разрядом с помощью [tool], но реакции нет.</span>")
	playsound(get_turf(target), 'sound/blank.ogg', 50, TRUE)
	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15, 180)
	return FALSE
